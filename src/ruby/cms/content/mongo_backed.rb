
require 'mongo'

module Pixelcop
    module CMS
        
        class MongoBackedContent < Content
            
            attr_reader :keys

            # API implementation
            
            class << self
            
                def load(selector = {}, options = {})
                    results = find(selector, options)
                    return nil if results.empty?
                    return results[0]
                end
            
                def find(selector = {}, options = {})
                    if options.empty? or not options.include? "limit" then
                        # set default limit
                        options[:limit] = 20
                    end
                    if selector.include? :id then
                        if selector[:id].kind_of? String then
                            selector[:_id] = Mongo::ObjectID.from_string(selector[:id])
                            selector.delete(:id)
                        else
                            selector[:_id] = selector[:id]
                            selector.delete(:id)
                        end
                    end
                    results = []
                    cursor = collection.find(selector, options)
                    cursor.each { |row| 
                        results << new_from_mongo(row)
                    }
                    return results
                end
            
            end # self
            
            def save
                hash = {}
                raise "No keys to save!" if not @@keys
                super
                @@keys.each { |k|
                    next if k.to_s == 'id'
                    hash[k] = read_attr(k)
                }
                id = collection.save(hash)
                @id = id.to_s
            end

            # utils
            
            def collection
               self.class.collection() 
            end
                
                
            # class methods
            
            class << self        
            
                def connection
                    @@connection ||= Mongo::Connection.new
                end
            
                def connection=(conn)
                    @@connection = conn
                end
            
                def database
                    @@database
                end
            
                def database=(db)
                    @@database = connection.db(db)
                end
            
                def collection
                   @@collection ||= @@database.collection(collection_name())
                end
                
                def collection=(coll)
                    @@collection = coll
                end
            
                def collection_name
                    @@collection_name ||= "content"
                end
            
                def collection_name=(name)
                    @@collection_name = name
                end

                # define an attribute as storable
                def key(*args)
                    @@keys ||= []
                    args.each { |k|
                        @@keys << k if not @@keys.include? k
                    }
                end
            
            
                private
            
                def new_from_mongo(row)
                    obj = new()
                    @@keys.each { |k|
                        if k == :id then
                            obj.write_attr("id", row["_id"].to_s)
                        else
                            obj.write_attr(k, row[k.to_s])
                        end
                    }
                    return obj
                end
            
            end # self
            
            key :id, :type, :name, :body, :created_at, :updated_at
            
        end # MongoBackedContent
        
    end # CMS
end # Pixelcop
# ~> -:2:in `require': no such file to load -- mongo (LoadError)
# ~> 	from -:2
