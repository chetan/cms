
module MyApp
    
    class HelloWorldController < Pixelcop::Web::BaseController
                
        def index()
            logger.debug{"hello world!"}
            render("hello_world.erb")            
        end
        
    end # HelloWorldController
    
end # end MyApp