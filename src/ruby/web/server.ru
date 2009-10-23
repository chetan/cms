
# rackup configuration
# configures rack and some basic rack middleware
# then ties the webserver (any webserver) to our app 

__DIR__ = File.dirname(__FILE__)

use Rack::CommonLogger
use Rack::Static, :urls => ["/css", "/images", "/favicon.ico"], :root => __DIR__ + '/../web'
use Rack::Reloader
use Rack::ContentLength

# setup autoloads

module Pixelcop
  autoload :Main, "main"
  module Web
    autoload :Application, "web/rack"
    autoload :Request, "web/http"
    autoload :Response, "web/http"
  end
end

run Pixelcop::Web::Application.new
