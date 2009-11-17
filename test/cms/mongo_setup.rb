
require 'cms/content'
require 'cms/content/text'

Pixelcop::CMS::MongoStorage.default_connection = Mongo::Connection.new("localhost")
Pixelcop::CMS::MongoStorage.default_database = "mycms_tests"

puts "NOTE: using database #{Pixelcop::CMS::MongoStorage.default_database} for testing"
