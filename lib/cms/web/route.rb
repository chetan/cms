
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
            
        class Route < Pixelcop::Web::Route
            
            include Pixelcop::CMS::MongoStorage
            @@collection_name = "route"
            
        end # Route
        
        end # Web
    end # CMS
end # Pixelcop