
module Pixelcop
    module Web
        
    class Despatcher    
    
        # class methods / attributes
        
        class << self
            
            attr_accessor :controller_path
            
            def handle(request)
                
                route, match = Router.select_route(request)
                if route.nil? then
                    puts "oh noes, no route :("
                end
                
                puts "i has a route!"
                
                controller = route.clazz.new(request, Response.new)
                controller.send(route.action)
                
                return controller.response
                                
            end

            # find and load controller scripts
            def init()
               scan_dir(Dir.new(@controller_path))
            end
            
            def scan_dir(dir)
                
                dir.each { |e|
                    next if e == "." or e == ".."
                    p = dir.path + "/" + e
                    if File.directory? p then
                        scan_dir(Dir.new(p))
                    else
                        require p
                    end                        
                }
                
            end
        
        end # self
    
    end # Despatcher
    
    end # Web    
end # Pixelcop
