
module Pixelcop
  autoload :Main, "main"
  module Web
    autoload :Application, "web/rack"
    autoload :Request, "web/http"
    autoload :Response, "web/http"
    
    autoload :Router, "web/route"
    autoload :Route, "web/route"
    autoload :Despatcher, "web/despatcher"
    
    autoload :BaseController, "web/controller"
    
  end
end