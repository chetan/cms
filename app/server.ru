
# rackup configuration
# configures rack and some basic rack middleware
# then ties the webserver (any webserver) to our app 

__DIR__ = Dir.pwd + "/" + File.dirname(__FILE__)

$: << __DIR__ + "/../src/ruby"

use Rack::CommonLogger
use Rack::Static, :urls => ["/css", "/images", "/favicon.ico"], :root => __DIR__ + '/public'
use Rack::Reloader
use Rack::ContentLength

# setup autoloads

require 'monkey'
require 'web'

# load routes - this should be done in some sort of config

Pixelcop::Web::Config.views_path = __DIR__ + "/views"

Pixelcop::Web::Despatcher.controller_path = __DIR__ + "/controller"
Pixelcop::Web::Despatcher.init()

Pixelcop::Web::Router.map("/", "MyApp::TestController", "index")

Pixelcop::Web::Views # loads view system

run Pixelcop::Web::Application.new
