require 'rails/generators'
require "rails/generators/active_record"

module PgAssistant
  module Generators
    class FunctionGenerator < Rails::Generators::NamedBase
      include Rails::Generators::Migration

      source_root File.expand_path("../templates", __FILE__)

      def create_functions_directory
        unless functions_directory_path.exist?
          empty_directory functions_directory_path
        end
      end

      def create_function_definition
        if creating_new_function?
          create_file definition.path
        else
          copy_file previous_definition.full_path, definition.full_path
        end
      end

      def create_migration_file
        if creating_new_function? || destroying_initial_function?
          migration_template(
            "db/migrate/create_function.erb",
            "db/migrate/create_#{function_name}.rb"
          )
        else
          migration_template(
            "db/migrate/update_function.erb",
            "db/migrate/update_#{function_name}_to_version_#{version}.rb"
          )
        end
      end

      def self.next_migration_number(dir)
        ::ActiveRecord::Generators::Base.next_migration_number(dir)
      end

      no_tasks do
        def previous_version
          @previous_version ||=
            Dir.entries(functions_directory_path)
              .map { |name| version_regex.match(name).try(:[], "version").to_i }
              .max
        end

        def version
          @version ||= destroying? ? previous_version : previous_version.next
        end

        def migration_class_name
          if creating_new_function?
            "Create#{class_name.gsub('.', '')}"
          else
            "Update#{class_name}ToVersion#{version}"
          end
        end

        def activerecord_migration_class
          if ActiveRecord::Migration.respond_to?(:current_version)
            "ActiveRecord::Migration[#{ActiveRecord::Migration.current_version}]"
          else
            "ActiveRecord::Migration"
          end
        end

        def definition
          PgAssistant::Definitions::Function.new(function_name, version)
        end

        def previous_definition
          PgAssistant::Definitions::Function.new(function_name, previous_version)
        end
      end

      private

      def functions_directory_path
        @functions_directory_path ||= Rails.root.join PgAssistant::Definitions::Function.directory_path
      end

      def version_regex
        /\A#{function_name}_v(?<version>\d+)\.sql\z/
      end

      def function_name
        @function_name ||= file_name.gsub(".", "_")
      end

      def destroying?
        behavior == :revoke
      end

      def creating_new_function?
        previous_version == 0
      end

      def destroying_initial_function?
        destroying? && version == 1
      end
    end
  end
end
