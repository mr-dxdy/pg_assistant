require 'pg_assistant/version'
require 'pg_assistant/definitions'

module PgAssistant
  class << self
    def configure(&block)
      yield(self)
    end

    def functions_directory_path=(path)
      Definitions::Function.directory_path = path
    end
  end
end

PgAssistant.configure do |config|
  config.functions_directory_path = 'db/functions'
end
