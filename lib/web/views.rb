
module Pixelcop
    module Web
        module Views
        
            autoload :BaseView, "web/views/base_view"
            autoload :Erb, "web/views/erb"
        
        end # Views
    end # Web
end # Pixelcop

module Pixelcop
    
    module Web 
    
        module Views
                        
            def render(filename)
                view = create_view(filename)                
                view.render(self)
            end
            
            def get_binding
               return binding 
            end
            
            private
            
            def create_view(filename)
            
                if not filename =~ /\.(.*)$/ then
                    # TODO raise error
                end
                ext = $1.downcase
                
                view = nil
                case ext
                
                    when "erb", "rhtml" then
                        return Erb.new(filename)
                
                end
                
                # TODO raise error
            end
        
        end # Views
        
        class BaseController        
            include Views
        end # BaseController
        
    end # Web
    
end # Pixelcop
