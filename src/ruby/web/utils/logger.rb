
require "log4r"

module Pixelcop
    module Web
        
        @@logger = Log4r::Logger.new("web")
        @@logger.outputters = Log4r::Outputter.stdout
        @@logger.level = Log4r::WARN
        
        def self.logger
            @@logger
        end
       
        module Logger
        
            # TODO might be a good idea to be able to get loggers by name here
            # perhaps some way to set one for different controllers or routes
            def logger
                @@logger
            end
            
            def self.included (mod)
                @@logger = Log4r::Logger["web::controller"] # check if it was already setup (say at startup)
                return if not @@logger.nil?
                @@logger = create_default_logger()
            end
            
            private
            
            def self.create_default_logger
                logger = Log4r::Logger.new("web::controller")
                stdout = Log4r::Outputter.stdout
                stdout.formatter = Log4r::PatternFormatter.new(:pattern => "[%5l] %d [%C] :: %m")
                logger.outputters = stdout
                logger.level = Log4r::DEBUG
                logger.trace = true
                logger.additive = false
                return logger
            end
            
        end # Logger
        
        class BaseController
            include Logger
        end # BaseController
       
    end # Web
end # Pixelcop