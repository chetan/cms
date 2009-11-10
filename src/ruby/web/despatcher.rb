
module Pixelcop
    module Web
    
    # The function of the Despatcher is to find a Route using the Router
    # and pass the request on to the selected controller & action. 
    
    class Despatcher    
    
        # class methods / attributes
        
        class << self
            
            attr_accessor :controller_paths # TODO move to Config?
            
            def handle(request)
                
                route, match = Router.select_route(request)
                if route.nil? then
                    # TODO raise error
                end

                controller = route.clazz.new(request, Response.new)
                controller.send(route.action)
                
                return controller.response

            end

            # find and load controller scripts
            def init(paths)
                if @controller_paths.nil? then
                    @controller_paths = []
                end
                return if paths.nil?
                if paths.kind_of? String
                    @controller_paths << paths
                else
                    @controller_paths += paths
                end
                @controller_paths.each { |path|
                    scan_dir(Dir.new(path))
                }
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
