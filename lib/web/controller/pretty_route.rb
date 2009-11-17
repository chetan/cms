
require "web/controller/segment"

module Pixelcop
    module Web
    
    class PrettyRoute < Route
        
        # class methods / variables
        class << self
            attr_reader :controllers, :actions
            @controllers = {}
            @actions = {}
        end
        
        attr_reader :segments, :regex, :mod
        
        def_init :pattern, :mod
       
        def initialize(*args)
            super
            compile()
        end
       
        def handle? (request)
            return @regex.match(request.path)
        end
        
        def handle (request, match)

            puts match[0]
            classname = match[@controller.pos]
            action = match[@action.pos] || "index"
            clazz = find_controller(classname, @mod)
            
            puts "found #{clazz}"
            puts "calling #{clazz}.#{action}"
            
            controller = clazz.new(request, Response.new)
            controller.send(action)
            return controller
                        
        end
        
        # # override getter
        # def controller
        #     con = @@controllers[]
        # end
        # 
        # # override getter
        # def action
        #     
        # end
              
        private
       
        # TODO throw error on failure
        def compile
            @clazz = eval(@controller) if not @controller.blank?
            create_segments()
            route_str = ""
            i = 0
            @segments.each { |seg|
                case seg
                when ControllerSegment
                    @controller = seg
                    route_str << "([^/]+)"
                    seg.pos = (i += 1)
                when ActionSegment
                    @action = seg
                    route_str << "([^/]+)?"
                    seg.pos = (i += 1)
                when ParamSegment
                    #@action = seg
                    route_str << "([^/]+)"
                    seg.pos = (i += 1)
                else
                    route_str << seg.path
                end                     
            }
            puts route_str
            @regex = Regexp.new(route_str)
        end
        
        def create_segments
            rest = @pattern
            @segments = []
            until rest.empty?
                segment, rest = next_segment(rest)
                @segments << segment
            end
        end
        
        def next_segment(path)
            
            segment = 
                case path
                when /\A:(\w+)/ # using symbols as placeholders
                    key = $1.to_sym
                    case key
                    when :controller
                        ControllerSegment.new(key)
                    when :action
                        ActionSegment.new(key)
                    else
                        ParamSegment.new(key)
                    end
                when %r{\A([^/]+)} # any bit of text
                    StaticSegment.new($&)
                when %r{/} # a path divider - currently only slash '/' is allowed
                    DividerSegment.new($&)
                end
                
            return [segment, $~.post_match]            
        end
       
    end # PrettyRoute
    
    end # Web
end # Pixelcop
