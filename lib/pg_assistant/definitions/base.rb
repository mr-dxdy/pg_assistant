module PgAssistant
  module Definitions
    class Base
      class << self
        attr_reader :directory_path

        def directory_path=(path_raw)
          @directory_path = Pathname.new(path_raw)
        end
      end

      def initialize(name, version)
        @name = name
        @version = version.to_i
      end

      def to_sql
        File.read(full_path)
      end

      def full_path
        Rails.root.join(path)
      end

      def path
        self.class.directory_path.join(filename)
      end

      def version
        @version.to_s.rjust(2, "0")
      end

      def filename
        "#{@name}_v#{version}.sql"
      end
    end
  end
end
