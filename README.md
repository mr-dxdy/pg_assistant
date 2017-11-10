# PgAssistant

Adds methods to ActiveRecord::Migration to create and manage database functions in Rails.
I took the idea from a project [Scenic](https://github.com/thoughtbot/scenic).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pg_assistant'
```

## Setup config

```ruby
PgAssistant.configure do |config|
  config.functions_directory_path = '<your path>' # by default db/functions
end
```

## Usage

Create or update function:

``` bash
rails generate pg_assistant:function increment

# => create: db/functions/increment_v01.sql
# => create: db/functions/20140803191158_create_increment.rb

rails generate pg_assistant:function increment

# => create: db/functions/increment_v02.sql
# => create: db/functions/20140804191158_update_increment_to_version_2.rb
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
