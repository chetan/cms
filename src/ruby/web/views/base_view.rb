
module Pixelcop
    
    module Web 
    
        module Views

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

    end # Web
    
end # Pixelcop