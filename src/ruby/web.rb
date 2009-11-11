
module Pixelcop
    
    autoload :Main, "main"
    
    module Web
        
        autoload :Config, "web/config"
        
        # Basic Rack stuff
        autoload :Application, "web/application"
        autoload :Request, "web/http"
        autoload :Response, "web/http"
    
        # Despatcher, routing
        autoload :Router, "web/router"
        autoload :Route, "web/route"
        autoload :RegexRoute, "web/controller/regex_route"
        autoload :PrettyRoute, "web/controller/pretty_route"
        autoload :Despatcher, "web/despatcher"
        autoload :BaseController, "web/base_controller"

        # Views, templates
        autoload :Views, "web/views"
        autoload :CachedViews, "web/views/cached_views"
        
    end # Web
    
end # Pixelcop