
module Pixelcop
    
    module Web 
    
        module CachedViews
                        
            def render(filename)
                view = create_cached_view(filename)                
                view.render(self)
            end
            
            private
                        
            def create_cached_view(filename)
                
                # check cache
                if cached = @@view_cache[filename] then
                    return cached
                end

                # get new view
                view = create_view(filename)
                
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
            include CachedViews
        end # BaseController
        
    end # Web
    
end # Pixelcop
