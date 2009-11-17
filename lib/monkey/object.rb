
class Object

    def self.read_attr(name)
        begin
            return class_variable_get("@@#{name}")
        rescue NameError => e
            return nil
        end
    end
    
    def self.write_attr(name, val)
        class_variable_set("@@#{name}", val)
    end
   
    def read_attr(name)
        respond_to?(name.to_sym) ? send(name.to_sym) : instance_variable_get("@#{name}")
    end
    
    def write_attr(name, val)
        instance_variable_set("@#{name}", val)
    end
   
    def blank?
        respond_to?(:empty?) ? empty? : !self
    end
    
end