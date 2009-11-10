#\ -p 3000

# #\ -w -p 3000

# rackup configuration
# configures rack and some basic rack middleware
# then ties the webserver (any webserver) to our app 

__DIR__ = File.dirname(__FILE__)
__DIR__ = Dir.pwd + "/" + __DIR__ if __DIR__ !~ %r|^/|

$: << __DIR__ + "/../src/ruby"

#use Rack::CommonLogger
use Rack::Static, :urls => ["/css", "/images", "/favicon.ico"], :root => __DIR__ + '/public'
use Rack::Reloader
use Rack::ContentLength

# setup autoloads

require 'monkey'
require 'web'
require 'cms'

# configure cms

Pixelcop::CMS::MongoBackedContent.connection = Mongo::Connection.new("localhost")
Pixelcop::CMS::MongoBackedContent.database = 'mycms'

# load routes - this should be done in some sort of config

Pixelcop::Web::Config.views_path = __DIR__ + "/views"
Pixelcop::Web::Despatcher.init(__DIR__ + "/controller")

Pixelcop::Web::Router.map("/content/update.*", "MyApp::ContentController", "update")
Pixelcop::Web::Router.map("/content/edit.*", "MyApp::ContentController", "edit")
Pixelcop::Web::Router.map("/content/(new|create).*", "MyApp::ContentController", "create")
Pixelcop::Web::Router.map("/content/view.*", "MyApp::ContentController", "view")
Pixelcop::Web::Router.map("/content/.*", "MyApp::ContentController", "index")

Pixelcop::Web::Router.map("/", "MyApp::HelloWorldController", "index")

Pixelcop::Web::Views # loads view system (via autoload), adds it to the stack

run Pixelcop::Web::Application.new
