
module Pixelcop
    module Web
        
        class BaseController
            
            attr_accessor :request
            attr_accessor :response
            def_init :request, :response
            
            # quick helper method
            def redirect(target, status = 302)
                @response.redirect(target, status)
            end

        end # BaseController
        
    end # Web
end # Pixelcop