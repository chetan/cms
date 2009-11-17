
require "rubygems"
require "mongo"

module Pixelcop
    module CMS

        module MongoStorage

            class << self
                attr_accessor :default_database, :default_connection
            end

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

                    # this is probably slow, but the only surefire way, I think..
                    begin
                        super
                    rescue NoMethodError => e
                    end

                    # other option here is to catch NoMethodError
                    #super if self.class.superclass.instance_methods.include? "save"

                    keys.each { |k|
                        val = read_attr(k)
                        next if val.nil?
                        if k.to_s == 'id' then
                            hash[:_id] = Mongo::ObjectID.from_string(val)
                        else
                            hash[k] = val
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
                    @connection ||= Mongo::Connection.new
                end

                def connection=(conn)
                    @connection = conn
                end

                def database
                    @database ||= connection.db(MongoStorage.default_database)
                end

                def database=(db)
                    @database = connection.db(db)
                end

                def collection
                    @collection ||= database.collection(collection_name())
                end

                def collection=(coll)
                    @collection = coll
                end

                def collection_name
                    @collection_name ||= inherit_static_from_super(:collection_name) # || TODO raise error
                end

                def collection_name=(val)
                    @collection_name = val
                end

                # define an attribute as storable
                def key(*args)
                    args.each { |k|
                        self.keys << k if not keys.include? k
                    }
                end

                def keys
                    @keys ||= inherit_static_from_super(:keys) || []
                end


                private

                def inherit_static_from_super(sym)
                    if superclass.respond_to? sym then
                        val = superclass.send(sym)
                        return val.dup if not val.blank?
                    end
                    return nil
                end

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

        end # MongoStorage

    end # CMS
end # Pixelcop
