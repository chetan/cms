
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
    
    end # Web
end # Pixelcop
