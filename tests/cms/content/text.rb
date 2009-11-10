
__DIR__ = File.dirname(__FILE__)
__DIR__ = Dir.pwd + "/" + __DIR__ if __DIR__ !~ %r|^/|

$: << __DIR__ + "/../../../src/ruby"

require 'monkey'
require 'cms/content'
require '../mongo_setup'

require 'test/unit'

class TextContent_Test < Test::Unit::TestCase
    
    def teardown
        Pixelcop::CMS::MongoBackedContent.collection.drop
        Pixelcop::CMS::MongoBackedContent.collection = nil
    end
    
    def test_init
        obj = Pixelcop::CMS::Text.new({:name => "foo", :body => "blah"})
        assert_equal("foo", obj.name)
        assert_equal("blah", obj.body)
    end
    
    def test_save
        obj = Pixelcop::CMS::Text.new({:name => "foo", :body => "blah"})
        assert_nil(obj.id)
        assert(obj.new?)
        assert_nil(obj.created_at)
        obj.save()
        assert_not_nil(obj.id)
        assert_not_nil(obj.created_at)
        assert_equal(false, obj.new?)
        assert_equal(String, obj.id.class)
    end
    
    def test_update
        obj = Pixelcop::CMS::Text.new({:name => "foo", :body => "blah"})
        assert_nil(obj.id)
        assert(obj.new?)
        assert_nil(obj.created_at)
        obj.save()
        assert_not_nil(obj.id)
        assert_not_nil(obj.created_at)
        assert_equal(false, obj.new?)
        assert_equal(String, obj.id.class)
        id = obj.id
        obj.name = "foo2"
        obj.save()
        assert_not_nil(obj.id)
        assert_equal(id, obj.id) # id shouldn't have changed
        # try reloading it
        loaded = Pixelcop::CMS::Text.load(id)
        assert_not_nil(loaded)
        assert_equal(id, loaded.id)
        assert_equal("foo2", loaded.name)
    end
    
    def test_load
        obj = Pixelcop::CMS::Text.new({:name => "foo", :body => "blah"})
        obj.save()
        loaded = Pixelcop::CMS::Text.load({ :id => obj.id })
        assert_not_nil(loaded)
        assert_equal(String, loaded.id.class)
        assert_equal(obj.id, loaded.id)
        assert_equal("foo", loaded.name)        
    end
    
    def test_load_by_string_id
        obj = Pixelcop::CMS::Text.new({:name => "foo", :body => "blah"})
        obj.save()
        loaded = Pixelcop::CMS::Text.load(obj.id)
        assert_not_nil(loaded)
        assert_equal(String, loaded.id.class)
        assert_equal(obj.id, loaded.id)
        assert_equal("foo", loaded.name)
    end
    
    def test_delete
        obj = Pixelcop::CMS::Text.new({:name => "foo", :body => "blah"})
        obj.save()
        loaded = Pixelcop::CMS::Text.load({ :id => obj.id })
        assert_not_nil(loaded)
        # now try to delete it
        obj.delete()
        loaded = Pixelcop::CMS::Text.load({ :id => obj.id })
        assert_nil(loaded)
    end
    
end