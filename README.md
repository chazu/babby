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

You can contextualize domain objects as follows:

```
class Base
  include Babby::MetaDSL

  dsl_method :contextualize, type: :proc

  attr_accessor :entity

  def initialize(instance)
    @entity = instance
  end

  def generate
    puts "path: #{contextualize[:path]} content: #{contextualize[:content]}"
  end
end

class PooGenerator < Base
  contextualize Proc.new { |instance| { path: instance.path, content: instance.content } }
end

class Thing
  attr_accessor :path, :content

  def initialize(path, content)
    @path = path
    @content = content
  end
end

e = Thing.new('lol what', "poopsticks")
i = PooGenerator.new(e)

puts i.generate
```

### But inheritance is yucky
Yes, but not for is-a relationships. Besides, dogmatism is yucky too. :3


## Development

### TODOs
* add specs!!!
* Allow parameterization of derived class entity - see babby.rb:21
* add inflection/pluralization for arrays, with manual getter specification as a backup.
* Add ability to validate type of argument to dsl method
* Add ability to validate presence of hash keys on hash arguments

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Changelog

0.2.0 - Fixed glaring bug in 0.1.0 (static map missing from module)
      - Add proc