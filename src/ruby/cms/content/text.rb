
require 'cms/storage/mongomapper'

module Pixelcop
    module CMS
        
        class Text < MongoBackedContent
        
            def self.type
               "text"
            end
            
        end # Text
        
    end # CMS
end # Pixelcop