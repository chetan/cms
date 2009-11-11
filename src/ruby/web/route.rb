
module Pixelcop
    module Web
    
    class Route
       
        attr_accessor :pattern
        attr_accessor :controller 
        attr_accessor :action
        attr_reader :clazz

        def_init :pattern, :controller, :action
        
        def initialize(*args)
            super
            @clazz = eval(@controller) if not @controller.blank?
        end

        # returned result will be passed to the handle method
        def handle? (request)
            return request.path.start_with? @pattern
        end
        
        def handle (request, obj)
            controller = @clazz.new(request, Response.new)
            controller.send(@action)
            return controller
        end
       
    end # Route
    
    end # Web
end # Pixelcop
    