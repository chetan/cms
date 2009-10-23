
# rackup configuration
# configures rack and some basic rack middleware
# then ties the webserver (any webserver) to our app 

__DIR__ = File.dirname(__FILE__)

require __DIR__ + '/rack'

use Rack::CommonLogger
use Rack::Static, :urls => ["/css", "/images", "/favicon.ico"], :root => __DIR__ + '/../web'
use Rack::Reloader
use Rack::ContentLength

# setup autoloads

module Pixelcop
  module Web
    autoload :Request, "http"
    autoload :Response, "http"
  end
end

run Pixelcop::Web::Application.new
