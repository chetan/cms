
module MyApp
    
    class TestController < Pixelcop::Web::BaseController
                
        def index()
            
            puts "index.."
            
            render("test.erb")            
        end
        
    end # TestController
    
end # end MyApp