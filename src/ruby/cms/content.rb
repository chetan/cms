
module Pixelcop
    module CMS

        autoload :MongoBackedContent, "cms/content/mongo_backed"
        autoload :Text, "cms/content/text"
        autoload :HTML, "cms/content/html"
        
    end
end

module Pixelcop
    module CMS
        
        class Content

            # basic attributes for all content types

            attrib :id, :type, :name, :body, :created_at, :updated_at
    
            def initialize(args={})
                return if args.empty?
                args.each_pair do |name, value|
                    writer_method = "#{name}="
                    if respond_to?(writer_method)
                        self.send(writer_method, value)
                    else
                        self[name.to_s] = value
                    end
                end
            end
            
            def new?
                return read_attr('created_at').nil?
            end
            
            def update_timestamps
              now = Time.now.utc
              write_attr('created_at', now) if new?
              write_attr('updated_at', now)
            end
            
            def read_attr(name)
                instance_variable_get("@#{name}")
            end
            
            def write_attr(name, val)
               instance_variable_set("@#{name}", val)
            end
            
                
            # api - all content types must implement these methods
            
            # describes the content type
            def self.type
                raise NotImplementedError
            end
            
            # same args as self.find(), however returns a single object
            # instead of an array
            def self.load(selector={}, options={})
                raise NotImplementedError
            end
            
            # selector is a hash of keys to search/filter by
            # options can be:
            #   limit = <int> (default=20)
            def self.find(selector={}, options={})
                raise NotImplementedError
            end

            # can have before_save and after_save methods
            def save()
                raise NotImplementedError
            end

            # override as necessary, but don't forget to call super!
            def before_save()
                update_timestamps()
            end
            
            # override as necessary
            def after_save()
            end            
  
        end # Content

    end # CMS
end # Pixelcop