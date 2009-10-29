
module MyApp
    
    class TestController < Pixelcop::Web::BaseController
                
        def index()
            
            puts "index.."
            
            @response.body = "hi index!"
            
        end
        
    end # TestController
    
end # end MyApp