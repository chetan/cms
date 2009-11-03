
module MyApp
    
    class HelloWorldController < Pixelcop::Web::BaseController
                
        def index()
            render("hello_world.erb")            
        end
        
    end # TestController
    
end # end MyApp