
__DIR__ = File.dirname(__FILE__)
__DIR__ = Dir.pwd + "/" + __DIR__ if __DIR__ !~ %r|^/|

$: << __DIR__ + "/../../src/ruby"

require 'monkey'
require 'cms/content'
require 'test/unit'

class DummyContent < Pixelcop::CMS::Content
    def save()
        super
    end
end

class Content_Test < Test::Unit::TestCase
    
    # def setup
    # end

    # def teardown
    # end

    # def test_not_implemented_methods
    # 
    #     assert_raise(NotImplementedError) do
    #         DummyContent.find()
    #     end
    #     
    #     assert_raise(NotImplementedError) do
    #         DummyContent.load()
    #     end
    #     
    #     assert_raise(NotImplementedError) do
    #         DummyContent.type()
    #     end
    #     
    #     obj = DummyContent.new
    #     assert_raise(NotImplementedError) do
    #         obj.save()
    #     end
    #     
    # end
    
    def test_update_timestamps
        now = Time.now.utc
        obj = DummyContent.new
        assert_nil(obj.created_at)
        obj.update_timestamps
        assert_not_nil(obj.created_at)
        assert(obj.created_at > now)
    end
    
    def test_init
        obj = DummyContent.new({:type => "foo", :name => "bar"})
        assert_equal("foo", obj.type)
        assert_equal("bar", obj.name)
        assert_equal(0, obj.version)
        assert_nil(obj.id)
        
        obj = DummyContent.new
        assert_nil(obj.id)
        assert_nil(obj.type)
        assert_nil(obj.name)
        assert_equal(0, obj.version)
    end

end
