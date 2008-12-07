module AttributeAssembler
  module ActiveRecord
    
    def with_attribute(name, &extension)
      define_method(name) do
        AttributeProxy.new(self, name, &extension)
      end
    end
    
  end
end

ActiveRecord::Base.send :extend, AttributeAssembler::ActiveRecord