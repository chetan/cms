
require 'cms/storage/mongomapper'

module Pixelcop
    module CMS
        
        class Text < MongoBackedContent
                        
            # override the @type field
            def initialize(args={})
                args['type'] = self.type()
                super(args)
            end
            
            def self.type
               "text"
            end
            
        end # Text
        
    end # CMS
end # Pixelcop