
module Pixelcop
    
    autoload :Main, "main"
    
    module Web
        
        autoload :Config, "web/config"
        
        # Basic Rack stuff
        autoload :Application, "web/rack"
        autoload :Request, "web/http"
        autoload :Response, "web/http"
    
        # Despatcher, routing
        autoload :Router, "web/route"
        autoload :Route, "web/route"
        autoload :Despatcher, "web/despatcher"
        autoload :BaseController, "web/controller"

        # Views, templates
        autoload :Views, "web/views"
        
    end # Web
    
end # Pixelcop