
module Pixelcop
    module Web
    
    class Route
        
       attr_accessor :pattern
       attr_accessor :controller
       attr_accessor :clazz
       attr_accessor :action
       attrib :regex
       
       def_init :pattern, :controller, :action
       
       def initialize(*args)
           super
           compile()
       end
       
       def handle? (request)
           return @regex.match(request.path)
       end
       
       
       private
       
       # TODO throw error on failure
       def compile
           @regex = Regexp.new(pattern)
           @clazz = eval(@controller)
       end
       
    end # Route
    
    end # Web
end # Pixelcop
    