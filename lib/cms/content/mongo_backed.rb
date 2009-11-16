
require "rubygems"
require "mongo"

module Pixelcop
    module CMS
        
        module MongoStorage
           
            # API implementation
            
            module ClassScope
            
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
                    if selector.kind_of? String then
                        # convert String to Hash with id
                        selector = { :_id => Mongo::ObjectID.from_string(selector) }
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
            
            end # ClassScope
            
            # instance methods
            
            module InstanceScope
                                
                def save
                    hash = {}
                    raise "No keys to save!" if not keys
                    super
                    keys.each { |k|
                        val = read_attr(k)
                        next if val.nil?
                        if k.to_s == 'id' then
                            hash[:_id] = Mongo::ObjectID.from_string(val)
                        else
                            hash[k] = read_attr(k)
                        end
                    }
                    id = collection.save(hash)
                    @id = id.to_s
                end
            
                def delete
                    # TODO raise error if new? or @id.nil?
                    selector = { :_id => Mongo::ObjectID.from_string(@id) }
                    collection.remove(selector)
                end

                # accessors for class vars
            
                def collection
                   self.class.collection() 
                end
                
                def keys
                    return self.class.keys()
                end
                
            end # InstanceScope
                                
            # class methods
            
            module ClassScope
            
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
                    args.each { |k|
                        keys << k if not keys.include? k
                    }
                end
                
                def keys
                    @@keys ||= []
                end
            
            
                private
            
                def new_from_mongo(row)
                    obj = new()
                    keys.each { |k|
                        if k == :id then
                            obj.write_attr("id", row["_id"].to_s)
                        else
                            obj.write_attr(k, row[k.to_s])
                        end
                    }
                    return obj
                end
            
            end # ClassScope
            
            def self.included(mod)
                mod.class_eval do
                    extend ClassScope
                    include InstanceScope
                end
            end
            
        end
        
        class MongoBackedContent < Content

            include MongoStorage
            @@collection_name = "content"
            
            key :id, :type, :name, :body, :created_at, :updated_at
            
        end # MongoBackedContent
        
    end # CMS
end # Pixelcop