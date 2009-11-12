
module Pixelcop
    module CMS
        
        class Content

            # basic attributes for all content types

            attr_accessor :id, :pretty_id, :type, :name, :created_at, :updated_at, :version
    
            def initialize(args={})
                @version = 0
                @type = self.class.name
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
            
            # same args as self.find(), however returns a single object
            # instead of an array
            def self.load(selector={}, options={})
                # raise NotImplementedError
            end
            
            # selector is a hash of keys to search/filter by
            # options can be:
            #   limit = <int> (default=20)
            def self.find(selector={}, options={})
                # raise NotImplementedError
            end

            # can have before_save and after_save methods
            chainable do
                def save()
                    update_timestamps()
                    @version += 1
                end
            end
            
            def save()
                # raise NotImplementedError
                super
            end
            
            def delete()
                
            end
            
        end # Content

    end # CMS
end # Pixelcop