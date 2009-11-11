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
use Rack::ShowExceptions

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

Pixelcop::Web::Router.class_eval do 
    
    add_route Pixelcop::Web::PrettyRoute.new("/:controller/:action", "MyApp")
    
    
    # following 5 routes are equivalent to the above route
    
    # map %r{^/content/update.*}, "MyApp::ContentController", "update"
    # map %r{^/content/edit.*}, "MyApp::ContentController", "edit"
    # map %r{^/content/(new|create).*}, "MyApp::ContentController", "create"
    # map %r{^/content/view.*}, "MyApp::ContentController", "view"
    # map %r{^/content/.*}, "MyApp::ContentController", "index"

    map %r{^/}, "MyApp::HelloWorldController", "index"
    
end


# class MockRequest
#     attrib :path
# end
# req = MockRequest.new("/content/content/view")
# ret = seg.handle? req
# seg.handle (req, ret)
# exit



Pixelcop::Web::Views # loads view system (via autoload), adds it to the stack

run Pixelcop::Web::Application.new
