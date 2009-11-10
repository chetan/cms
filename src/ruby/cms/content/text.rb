
require 'cms/storage/mongomapper'

module Pixelcop
    module CMS
        
        class Text < MongoBackedContent
            
            attr_accessor :body
            key :body
        
            def self.type
               "text"
            end
            
        end # Text
        
    end # CMS
end # Pixelcop