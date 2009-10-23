
__DIR__ = File.dirname(__FILE__)

require __DIR__ + '/rack'

use Rack::CommonLogger
use Rack::Static, :urls => ["/css", "/images", "/favicon.ico"], :root => __DIR__ + '/../web'
use Rack::ContentLength



run Pixelcop::Rack::Application.new