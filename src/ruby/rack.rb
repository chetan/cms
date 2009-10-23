
module Pixelcop
  module Web
      
    class Application
      
        def call(env)         
          dup.call!(env)
        end
        
        def call!(env)
          
          @request = Request.new(env)
          @response = Response.new
          
          require 'yaml'
          puts "te"
          puts @request["hi"]
      
          begin
          
              return   [
                        200,          # Status code
                        {             # Response headers
                          'Content-Type' => 'text/html',
                          'Content-Length' => '2',
                        },
                        ['hi']        # Response body
                       ]
              
              
          
              #return ::Merb::Dispatcher.handle(Merb::Request.new(env))
          rescue Object => e
              return [
                  500, 
                  {Merb::Const::CONTENT_TYPE => Merb::Const::TEXT_SLASH_HTML}, 
                  e.message + Merb::Const::BREAK_TAG + e.backtrace.join(Merb::Const::BREAK_TAG)
                  ]
          end
          
        end

    end # Application
  end # Rack
end # Pixelcop