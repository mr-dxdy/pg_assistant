module DefinitionHelpers
  def with_function_definition(name, version, schema, &block)
    _with_definition(PgAssistant::Definitions::Function, name, version, schema, &block)
  end

  def _with_definition(klass, name, version, schema)
    definition = klass.new(name, version)
    FileUtils.mkdir_p(File.dirname(definition.full_path))
    File.open(definition.full_path, "w") { |f| f.write(schema) }
    yield
  ensure
    FileUtils.rm_f(definition.full_path)
  end
end
