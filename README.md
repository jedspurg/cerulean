# Cerulean

[![Build Status](https://travis-ci.org/t27duck/cerulean.svg?branch=master)](https://travis-ci.org/t27duck/cerulean)

When working with models in a large Rails project, you sometimes end up with "god objects" which start to be loaded down with several booleans, integers, and strings from select boxes that act as configuration options. As time goes on, you add more and more columns. As your database and user-base grows, adding even a single column more can bring your app to a hang during a deploy due to table locking or a slew of exceptions due to [issues and gotchas like this](https://github.com/rails/rails/issues/12330).

In an attempt to cut down on cluttering your model with boolean columns, `cerulean` allows you to have a single column contain all configuration switches you could ever want. Adding another configuration option to a model no longer requires a migration to add a column. You can also continue writing code as if the model had all of those individual attributes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cerulean'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cerulean

## Usage

Let's say we have a model called `Client` whose job is to hold the general information configuration for a client in a multi-tenant application. First, we need to add one column to the model to hold the configuration information. By default, the gem assumes the column's name is `configuration`, but you can change that (more on that later).

```ruby
class AddConfigurationToClients < ActiveRecord::Migration
  add_column :clients, :configuration, :text
end
```

We now want to make that column a serialized hash in our model and include the `Cerulean::ActiveReocrd::ModelAdapter` module.

```ruby
class Client < ActiveRecord::Base
  serialize :configuration, Hash
  include Cerulean::ActiveRecord::ModelAdapter
end
```

If you are using PostgreSQL 9.2 or later, you can use the JSON or JSONB (if using Rails 4.2 or later) data-type for the configuration column and not have to declare it as a serilaized attribute in the model as `ActiveRecord` will take care of that for you.

If you want to use a different column name, you may override the default by setting `self.cerulean_settinguration_column = 'other_column_name'` in the model.

```ruby
class Client < ActiveRecord::Base
  serialize :configuration, Hash
  include Cerulean::ActiveRecord::ModelAdapter
  cerulean_setting :primary_color, config: { type: :string, default: 'green' }
  cerulean_setting :secondary_color, config: { type: :string }
  cerulean_setting :rate_limit, config: { type: :integer, validations: { numericality: { only_integer: true } } }
  cerulean_setting :category, config: { type: :string, validations: { inclusion: { in: CATEGORIES } } }
  cerulean_setting :active, config: { type: :boolean, default: false }
end
```
The `cerulean_setting` method is the primary interface for adding a setting to a model. The first argument is a symbol that represents the name of the setting.

The `config` key is a hash that contains information describing your setting. The `type` is the only required key when including the `config` option.

`type` is the datatype of your setting. Valid options are `string`, `integer`, and `boolean`.

`default` is the value that will be used if the record does not have this setting set. If no `default` is provided, `nil` will be used.

`validations` allows the setting to use the standard ActiveRecord validations you'd use for any regular attribute.

Ok, still with me? Back to our example...

Here, the `Client` model has five configuration items on it: `primary_color`, `secondary_color`, `rate_limit`, `category`, and `active`. So, knowing what you just learned above...

`primary_color` is a string with a default value of "green".

`secondary_color` is a string without a default.

`rate_limit` is an integer that validates its value is in fact, an integer.

`category` is a string that must be a value in the array `CATEGORIES`.

`active` is a boolean value with a default of `false`.

We can now access these configuration settings as if they were regular attributes on the model:

```irb
client = Client.new
client.default_color
=> "green"
client.secondary_color
=> nil
client.active
=> false
client.active?
=> false
client.active = '1' # Like if this was submitted from a form
=> '1'
client.active?
=> true
client.rate_limit = 3
=> 3
client.valid?
=> false
client.errors.full_messages
=> ["Category is not in the list"]
```

Everything acts pretty much as you'd expect it too do. Configurations that fail validations make the record invalid. Passing in '1', 'true', `true`, etc casts boolean values. Passing in an empty string for an integer config casts as `nil`.

## Chaining with other models with the same setting

TODO: Explain this

## Configuration file

An alternative to defining the definition of each setting in your model is to put them in a centralized configuration file.

Giving a file located at `#{Rails.root}/config/cerulean_settings.rb`:

````
setting :primary_color, :string, default: 'green'
setting :secondary_color, :string
setting :rate_limit, :integer, validations: { numericality: { only_integer: true } }
setting :category, :string, validations: { inclusion: { in: CATEGORIES } }
setting :active, :boolean, default: false
````

... and then somewhere in your app, call `Cerulean::Engine.load` (There's an optional `path:` argument to specify a different file path)

This will load up pre-configured setting information in your app. You can then just refer to each setting by name in your model:

```ruby
class Client < ActiveRecord::Base
  serialize :configuration, Hash
  include Cerulean::ActiveRecord::ModelAdapter
  cerulean_setting :primary_color
  cerulean_setting :secondary_color
  cerulean_setting :rate_limit
  cerulean_setting :category
  cerulean_setting :active
end
```

You can also override the `default` and `validations` settings for a pre-defined configuration:

```ruby
cerulean_setting :primary_color, config: { default: 'custom_value_unique_to_this_model' }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/t27duck/cerulean.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

