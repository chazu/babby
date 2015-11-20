# How is Babby Formed?

A simple mixin to help crank out ruby DSLs a la ActiveRecord. Provides a method which adds a class instance variable, a class method to set that variable and an instance variable to retrieve the value for derived classes. For example:

```
class MyBase
  include Babby::MetaDSL

  dsl_method :thingy

  dsl_method :doodad, type: :array
end

class MyDerived < MyBase

  thingy "widget"

  doodad "lol"
  doodad "rofl"
end

i = MyDerived.new
i.thingy # => "widget"
i.doodad # => ["lol", "rofl"]
```

### But inheritance is yucky
Yes, but not for is-a relationships.

## Development

### TODOs
* add specs
* add inflection/pluralization for arrays, with manual getter specification as a backup.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

