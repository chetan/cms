
module Pixelcop
    module Web
            
        class Segment
            attr_reader :path
            def_init :path
        end # Segment
        
        class ParamSegment < Segment
            attr_accessor :pos
        end
        
        class ControllerSegment < ParamSegment
        end
        
        class ActionSegment < ParamSegment
        end
        
        class DividerSegment < Segment
        end
        
        class StaticSegment < Segment
        end
    

    end # Web
end # Pixelcop
