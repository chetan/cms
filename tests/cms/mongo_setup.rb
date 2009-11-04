
require 'cms/content'
require 'cms/content/text'

Pixelcop::CMS::MongoBackedContent.connection = Mongo::Connection.new("localhost")
Pixelcop::CMS::MongoBackedContent.database = 'mycms_tests'