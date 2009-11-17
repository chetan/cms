
require 'cms/content'
require 'cms/content/text'

Pixelcop::CMS::MongoStorage.default_connection = Mongo::Connection.new("localhost")
Pixelcop::CMS::MongoStorage.default_database = "mycms_tests"