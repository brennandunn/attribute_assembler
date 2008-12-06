module AttributeAssembler
  class AttributeProxy
    alias_method :proxy_extend, :extend
    instance_methods.each { |meth| undef_method(meth) unless meth =~ /(^__|^nil\?$|^send$|proxy_|^object_id$)/ }
    
    def initialize(reference, field, &extension)
      @reference, @field, @value = reference, field, reference[field]
      proxy_extend Module.new(&extension)
    end
    
    
    private
    
    def method_missing(meth, *args, &block)
      @value.send(meth, *args, &block)
    end
    
    
  end  
end