
module Pixelcop
    module Web
        module Views
        
            autoload :Erb, "web/views/erb"
        
        end # Views
    end # Web
end # Pixelcop

module Pixelcop
    
    module Web 
    
        module Views
            
            attr_accessor :views_path
            
            def render(filename)
            
                if not filename =~ /\.(.*)$/ then
                    # TODO raise error
                end
                ext = $1.downcase
                
                view = nil
                case ext
                
                    when "erb", "rhtml" then
                        # TODO perf - don't create new objects every time
                        view = Erb.new(filename)
                
                end
                
                if view.nil? then
                    # TODO raise error
                end
                
                view.render(self)
            
            end
            
            def get_binding
               return binding 
            end

            class BaseView

                attr_accessor :filename, :template
                
                def initialize(filename)
                    @filename = filename
                    @template = load(@filename)
                end
                
                def load(filename)
                    raise NotImplementedError
                end
            
                def render(template)
                    raise NotImplementedError
                end
                
                private
                
                def read_template(filename)
                    file = find_template(filename)
                    if file.nil? then
                        # TODO raise error
                    end
                    return File.read(file)
                end

                def find_template(filename)
                    return filename if File.file? filename

                    filename = Pixelcop::Web::Config.views_path + "/" + filename
                    return filename if File.file? filename

                    return nil
                end

            end # BaseView

        
        end # Views
        
        class BaseController        
            include Views
        end # BaseController
        
    end # Web
    
end # Pixelcop
