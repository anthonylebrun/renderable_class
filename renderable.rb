require 'erb'
require 'ostruct'

module Renderable
  TEMPLATE_ROOT = File.dirname(__FILE__)

  def self.included(base)
    base.class_eval do
      class << self
        def template(path)
          file = File.read File.expand_path(path, TEMPLATE_ROOT)
          @@template = ERB.new(file)
        end

        def template_bindings(*methods)
          @@bound_methods = methods
        end
      end
    end
  end

  def render
    namespace = OpenStruct.new(method_values_mapping(bound_methods))
    template.result(get_binding(namespace))
  end

  private

  def method_values_mapping(methods)
    Hash[methods.map{ |sym| [sym, send(sym)] }]
  end

  def get_binding(instance)
    instance.instance_eval { binding }
  end

  def template
    @@template
  end

  def bound_methods
    @@bound_methods
  end
end