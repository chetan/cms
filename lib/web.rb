
module Pixelcop
    
    autoload :Main, "main"
    
    module Web
        
        autoload :Config, "web/config"
        
        # Basic Rack stuff
        autoload :Application, "web/application"
        autoload :Request, "web/http"
        autoload :Response, "web/http"
    
        # Despatcher, routing
        autoload :Router, "web/controller/router"
        autoload :Route, "web/controller/route"
        autoload :RegexRoute, "web/controller/regex_route"
        autoload :PrettyRoute, "web/controller/pretty_route"
        autoload :Despatcher, "web/controller/despatcher"
        autoload :BaseController, "web/controller/base_controller"

        # Views, templates
        autoload :Views, "web/views"
        autoload :CachedViews, "web/views/cached_views"
        
        # Other
        autoload :Logger, "web/utils/logger"
        
    end # Web
    
end # Pixelcop