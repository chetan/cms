
module Pixelcop
    
    module CMS
        
        module Web
            
            module ContentRoute
                attr_accessor :content_id
            
                def content
                    return nil if @content_id.blank?
                    # lookup content
                
                end
            end
        
        end # Web
        
    end # CMS
    
    module Web
        
        # extend Route classes to make them storable
        
        class Route
            
            include Pixelcop::CMS::MongoStorage
            self.collection_name = "routes"
            
            attr_reader :id
            
            def type
                self.class.name
            end
            
            key :id, :type, :pattern, :controller, :action
            
        end # Route
        
        class PrettyRoute
            key :mod
        end
        
    end # Web
    
end # Pixelcop