module Serializeable
  extend ActiveSupport::Concern

  def as_indexed_json(*)
    @_indexed_json ||= build_indexed_json
  end

  def build_indexed_json
    self.serializer.new(self).as_json
  end

  def as_indexed_json!(*)
    self.build_indexed_json
  end

  def serializer
    self.class.serializer
  end

  module ClassMethods
    def serializer
      @serializer ||= serializer_defined?("#{self}Serializer") ?
          Object.const_get("#{cut_module(self.to_s)}Serializer") : Object.const_get("#{cut_module(self.superclass.to_s)}Serializer")
    end

    def serializer_defined?(name)
      name = cut_module(name)
      Object.const_get(name)
    rescue
      return Object.const_defined?(name)
    end

    def cut_module name
      splt = name.split('::')
      splt.length == 2 ? splt[1] : name
    end
  end
end

