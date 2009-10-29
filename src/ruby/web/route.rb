
module Pixelcop
    module Web
        
    class Router    
    
        # class methods / attributes
        
        class << self
            
        attr_accessor :routes
        
        def map(pattern, controller, action)
            @routes = [] if @routes.nil?
            @routes << Route.new(pattern, controller, action)
        end
        
        alias_method :add, :map
        alias_method :add_route, :map
    
        def select_route(request)
            match = nil
            @routes.each { |route|
                match = route.handle? request
                if not match.nil? then
                    return route, match
                end
            }
        end
        
        end # self
    
    end # Router
    
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
    end
    
    end # Web
end # Pixelcop
    