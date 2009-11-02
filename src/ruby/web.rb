
module Pixelcop
    
    autoload :Main, "main"
    
    module Web
        
        autoload :Config, "web/config"
        
        autoload :Application, "web/rack"
        autoload :Request, "web/http"
        autoload :Response, "web/http"
    
        autoload :Router, "web/route"
        autoload :Route, "web/route"
        autoload :Despatcher, "web/despatcher"
    
        autoload :BaseController, "web/controller"
    
        autoload :Views, "web/views"
        
    end # Web
    
end # Pixelcop