
module Pixelcop
    module Rack
    class Application
      
        # The main rack application call method.  This is the entry point from rack (and the webserver) 
        # to your application.  
        #
        # ==== Parameters
        # env<Hash>:: A rack request of parameters.  
        #
        # ==== Returns
        # <Array>:: A rack response of [status<Integer>, headers<Hash>, body<String, Stream>]
        #
        # :api: private
        def call(env) 
        
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