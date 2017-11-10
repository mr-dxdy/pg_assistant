require 'spec_helper'
require 'generators/pg_assistant/function/function_generator'

RSpec.describe PgAssistant::Generators::FunctionGenerator, :generator do
  it 'creates function definition and migration files' do
    migration = file("db/migrate/create_increment.rb")
    function_definition = file("db/functions/increment_v01.sql")

    run_generator ['increment']

    expect(migration).to be_a_migration
    expect(function_definition).to exist
  end

  it 'updates an existing function' do
    with_function_definition('increment', 1, '++i') do
      migration = file('db/migrate/update_increment_to_version_2.rb')
      function_definition = file('db/functions/increment_v02.sql')
      allow(Dir).to receive(:entries).and_return(['increment_v01.sql'])

      run_generator ['increment']

      expect(migration).to be_a_migration
      expect(function_definition).to exist
    end
  end

  context "for functions created in a schema other than 'public'" do
    it "creates function definition and migration files" do
      migration = file("db/migrate/create_non_public_increment.rb")
      function_definition = file("db/functions/non_public_increment_v01.sql")

      run_generator ["non_public.increment"]

      expect(migration).to be_a_migration
      expect(function_definition).to exist
    end
  end
end
