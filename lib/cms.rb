
module Pixelcop
    
    autoload :CMS, "cms/content"
    
    module CMS

        autoload :Content, "cms/content"
        autoload :MongoBackedContent, "cms/content/mongo_backed"
        autoload :Text, "cms/content/text"
        autoload :HTML, "cms/content/html"
        
    end
end

module Pixelcop
    module CMS
        
    end # CMS
end # Pixelcop