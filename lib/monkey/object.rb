
class Object
   
    def read_attr(name)
        instance_variable_get("@#{name}")
    end
    
    def write_attr(name, val)
       instance_variable_set("@#{name}", val)
    end
   
   def blank?
       respond_to?(:empty?) ? empty? : !self
   end
    
end