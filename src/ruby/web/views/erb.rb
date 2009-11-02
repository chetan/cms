
require 'erb'

module Pixelcop
    module Web
        module Views
        
            class Erb < BaseView
                
                def load(filename)
                   @template = ERB.new(read_template(filename))
                end
            
                def render(controller)
                    controller.response.body = @template.result(controller.get_binding)
                end
            
            end # Erb
        
        end # Views
    end # Web
end # Pixelcop