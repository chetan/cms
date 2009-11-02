
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
            
            attr_accessor :views_path
            
            def render(filename)
            
                if not filename =~ /\.(.*)$/ then
                    # TODO raise error
                end
                ext = $1.downcase
                
                view = nil
                case ext
                
                    when "erb", "rhtml" then
                        # TODO perf - don't create new objects every time
                        view = Erb.new(filename)
                
                end
                
                if view.nil? then
                    # TODO raise error
                end
                
                view.render(self)
            
            end
            
            def get_binding
               return binding 
            end
        
        end # Views
        
        class BaseController        
            include Views
        end # BaseController
        
    end # Web
    
end # Pixelcop
