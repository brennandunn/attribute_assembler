module AttributeAssembler
  module ActiveRecord
    
    def with_attribute(*args, &extension)
      options = args.extract_options!
      args.each do |name|
        define_method(name) do
          AttributeProxy.new(self, name, &extension)
        end
      end
    end
    alias :with_attributes :with_attribute
    
  end
end

ActiveRecord::Base.send :extend, AttributeAssembler::ActiveRecord