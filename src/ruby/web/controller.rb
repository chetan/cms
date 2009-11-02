
module Pixelcop
    module Web
        
        class BaseController
            
            attr_accessor :request
            attr_accessor :response
            def_init :request, :response
            
        end # BaseController
        
    end # Web
end # Pixelcop