# ErrorIndexer

Allows to index error messages on has many assoccitions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'error_indexer', github: 'okosyk/error_indexer'
```

And then execute:

    $ bundle

## Usage

Just add `index_errors: true` to  your `has_many` association.

Example:

```ruby
class DoubleHamburger < ActiveRecord::Base
  has_many :patties, index_errors: true
  accepts_nested_attributes_for :patties
end

class Patty < ActiveRecord::Base
  MEAT_TYPES = [
    "beef",
    "chicken",
    "pork"
  ]

  belongs_to :double_hamburger
  validates :meat_type, :inclusion=> { :in => MEAT_TYPES }
end
```

In case of validation failures on nested assocciations error messagges will look like this:

```ruby
{
  :"patties.0.meat_type" => ["is not included in the list"],
  :"patties.1.meat_type "=> ["is not included in the list"]
}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/okosyk/error_indexer.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
