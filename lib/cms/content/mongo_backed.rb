
require "mongo_storage"

module Pixelcop
    module CMS

        class MongoBackedContent < Content

            include MongoStorage
            self.collection_name = "content"

            key :id, :type, :name, :created_at, :updated_at

        end # MongoBackedContent

    end # CMS
end # Pixelcop
