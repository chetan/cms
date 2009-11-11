
module Pixelcop
    module Web
    
    class RegexRoute < Route
       
        def initialize(*args)
            super
            compile()
        end
       
        def handle? (request)
            return @pattern.match(request.path)
        end    
              
        private
       
        # TODO throw error on failure
        def compile
            if @pattern.kind_of? String then
                @pattern = Regexp.new(@pattern)
            end
            @clazz = eval(@controller)
        end
       
    end # RegexRoute
    
    end # Web
end # Pixelcop
