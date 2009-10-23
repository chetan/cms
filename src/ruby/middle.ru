
use Rack::CommonLogger

module Rack
  class Upcase
    def initialize app
      @app = app
    end
    
    def call env
      puts 'upcase'
      p @app
      puts
      status, headers, body = @app.call env
      puts "upcase returning"
      [status, headers, [body.first.upcase]]
    end
  end
end

module Rack
  class Reverse
    def initialize app
      @app = app
    end
    
    def call env
      puts 'reverse'
      p @app
      puts
      status, headers, body = @app.call env
      puts "reverse returning"
      [status, headers, [body.first.reverse]]
    end
  end
end

use Rack::Upcase
use Rack::Reverse
use Rack::ContentLength

app = lambda { |env| 
    puts "begin req"
    [200, { 'Content-Type' => 'text/html' }, 'Hello World'] 
}
run app