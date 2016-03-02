require_relative './renderable'

module Widget
  class HelloWorld
    include Renderable

    template 'hello_world.erb.html'
    template_bindings :greeting

    def initialize(name = nil)
      @name = name || 'World'
    end

    attr_reader :name

    def greeting
      "Hello, #{name}!"
    end
  end
end