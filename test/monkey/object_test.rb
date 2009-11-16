
require "monkey"

require "test/unit"

class Foo
    attr_accessor :bar, :baz
    def initialize
        @baz = "zab"
        @zeeb = "beez"
    end
end

class Object_Test < Test::Unit::TestCase
   
    def test_blank
        str = String.new
        assert(str.blank?)
        str = nil
        assert(str.blank?)
        assert(nil.blank?)
        assert("".blank?)
        assert([].blank?)
    end
    
    def test_attr_read
        foo = Foo.new
        assert_nil(foo.read_attr(:bar))
        foo.bar = "test"
        assert_not_nil(foo.read_attr(:bar))
        assert_not_nil(foo.read_attr(:baz))
        assert_not_nil(foo.read_attr(:zeeb))
    end
    
    def test_attr_write
        foo = Foo.new
        assert_nil(foo.read_attr(:bar))
        foo.write_attr(:bar, "test")
        assert_not_nil(foo.read_attr(:bar))
        assert_equal("test", foo.read_attr(:bar))
    end
    
end