
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

            attrib :id, :type, :name, :body, :created_at, :updated_at, :version
    
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
                @version = 0
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
            chainable do
                def save()
                    update_timestamps()
                    @version += 1
                end
            end
            
            def save()
                raise NotImplementedError
            end
            
        end # Content

    end # CMS
end # Pixelcop