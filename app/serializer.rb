class Serializer
  attr_reader :object

  def initialize(object)
    @object = object
  end

  class << self
    def attributes
      @attributes ||= {}
    end

    def attribute(name, &block)
      attributes[name] = block || proc { object.public_send(name) }
    end
  end

  def serialize
    self.class.attributes.transform_values do |block|
      instance_eval(&block)
    end
  end
end
