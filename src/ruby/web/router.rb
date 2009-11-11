
module Pixelcop
    module Web
        
    class Router    
    
        # class methods / attributes
        
        @routes = []
        
        class << self
            
        attr_accessor :routes
        
        def add_route(route)
            return if route.nil? or not route.kind_of? Route
            @routes << route
        end
        
        def map(pattern, controller, action)
            add_route( create_route(pattern, controller, action) )
        end
        
        def create_route(pattern, controller, action)
            if pattern.kind_of? Regexp then
                return RegexRoute.new(pattern, controller, action)
            else
                return Route.new(pattern, controller, action)
            end
        end
    
        def select_route(request)
            match = nil
            @routes.each { |route|
                ret = route.handle? request
                if ret then
                    return route, ret
                end
            }
        end
        
        end # self
    
    end # Router
    
    end # Web
end # Pixelcop
