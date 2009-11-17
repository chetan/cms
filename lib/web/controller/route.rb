
module Pixelcop
    module Web
    
    class Route
       
        attr_accessor :pattern
        attr_accessor :controller 
        attr_accessor :action
        attr_reader :clazz

        def_init :pattern, :controller, :action
        
        def initialize(*args)
            super
            @clazz = find_controller(@controller) if not @controller.blank?
        end

        # returned result will be passed to the handle method
        def handle? (request)
            return request.path.start_with? @pattern
        end
        
        def handle (request, obj)
            controller = @clazz.new(request, Response.new)
            controller.send(@action)
            return controller
        end
        
        private
        
        # look for controller class by name
        def find_controller(name, mod = nil)
            
            classname = (name =~ /::/ or name =~ /Controller/) ? name : name.capitalize
            
            # look in root scope
            classname = "::#{classname}" if not classname.start_with? "::"
            
            begin
                puts "finding #{classname}"
                return eval(classname)
            rescue NameError => e
            end
            
            if classname !~ /Controller/ then
                begin
                    puts "finding #{classname}Controller"
                    return eval("#{classname}Controller")
                rescue NameError => e
                end
            end
            
            return nil if mod.nil?
            

            # try prepending module name
            classname = "#{mod}#{classname}"
            
            begin
                puts "finding #{classname}"
                return eval(classname)
            rescue NameError => e
            end
            
            if classname !~ /Controller/ then
                begin
                    puts "finding #{classname}Controller"
                    return eval("#{classname}Controller")
                rescue NameError => e
                end
            end
            
            return nil
            
        end
       
    end # Route
    
    end # Web
end # Pixelcop
    