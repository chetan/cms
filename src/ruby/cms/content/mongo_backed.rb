
require 'mongo'

module Pixelcop
    module CMS
        
        class MongoBackedContent < Content
            
            attr_reader :keys
            
            # instance methods

            # API implementation
            
            def self.load(selector = {}, options = {})
                results = find(selector, options)
                return nil if results.empty?
                return results[0]
            end
            
            def self.find(selector = {}, options = {})
                if options.empty? or not options.include? "limit" then
                    # set default limit
                    options[:limit] = 20
                end
                if selector.include? :id then
                    if selector[:id].kind_of? String then
                        selector[:_id] = Mongo::ObjectID.from_string(selector[:id])
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
            
            def save
                hash = {}
                raise "No keys to save!" if not @@keys
                before_save() if respond_to? 'before_save'
                @@keys.each { |k|
                    next if k.to_s == 'id'
                    hash[k] = read_attr(k)
                }
                @id = collection.save(hash)
                after_save() if respond_to? 'after_save'
            end

            # utils
            
            def collection
               self.class.collection() 
            end
                
            # class methods
            
            
            def self.connection
                @@connection ||= Mongo::Connection.new
            end
            
            def self.connection=(conn)
                @@connection = conn
            end
            
            def self.database
                @@database
            end
            
            def self.database=(db)
                @@database = connection.db(db)
            end
            
            def self.collection
               @@collection ||= @@database.collection(collection_name())
            end
            
            def self.collection_name
                @@collection_name ||= "content"
            end
            
            def self.collection_name=(name)
                @@collection_name = name
            end

            # define an attribute as storable
            def self.key(*args)
                @@keys ||= []
                args.each { |k|
                    @@keys << k if not @@keys.include? k
                }
            end
            
            
            private
            
            def self.new_from_mongo(row)
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
            
            key :id, :type, :name, :body, :created_at, :updated_at
            
        end # MongoBackedContent
        
    end # CMS
end # Pixelcop
# ~> -:2:in `require': no such file to load -- mongo (LoadError)
# ~> 	from -:2
