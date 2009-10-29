
class Class

    # Allows the definition of methods on a class that will be available via
    # super.
    # 
    # ==== Examples
    #     class Foo
    #       chainable do
    #         def hello
    #           "hello"
    #         end
    #       end
    #     end
    #
    #     class Foo
    #       def hello
    #         super + " Merb!"
    #       end
    #     end
    #
    # Foo.new.hello #=> "hello Merb!"
    # 
    # ==== Parameters
    # &blk:: 
    #   a block containing method definitions that should be
    #   marked as chainable
    #
    # ==== Returns
    # Module:: The anonymous module that was created
    def chainable(&blk)
        mod = Module.new(&blk)
        include mod
        mod
    end

    # initialize() generator
    # author: Dave Hoover
    # source: http://redsquirrel.com/cgi-bin/dave/dynamic/def_init.html
    def def_init(*attrs)
        constructor = "chainable do\n"
        constructor << "def initialize("
        constructor << attrs.map{|a| a.to_s}.join(" = nil,") << " = nil"
        constructor << ")\n"
        attrs.each do |attribute|
            constructor << "@#{attribute} = #{attribute}\n"
        end
        constructor << "end\n"
        constructor << "end\n"
        class_eval(constructor)
    end
  
    # helper for creating class attributes with accessor and initializer
    #
    # usage:
    #
    # class Foo
    #   attrib :baz, :bar
    # end
    def attrib(*attrs)
        attr_accessor *attrs
        def_init *attrs
    end
  
end