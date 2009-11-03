
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
                view = create_cached_view(filename)                
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
            
            def create_cached_view(filename)
                
                # check cache
                if cached = @@view_cache[filename] then
                    return cached
                end

                # get new view
                view = find_view(filename)
                
                # cache it 
                @@view_cache[filename] = view
            end
            
            attr_accessor :view_cache
            
            def self.included(mod)
                @@view_cache = {}
            end
        
        end # Views
        
        class BaseController        
            include Views
        end # BaseController
        
    end # Web
    
end # Pixelcop
