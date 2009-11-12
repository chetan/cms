module Pixelcop
  module Web

    class Request < Rack::Request
      def user_agent
        @env['HTTP_USER_AGENT']
      end

      # Returns an array of acceptable media types for the response
      def accept
        @env['HTTP_ACCEPT'].to_s.split(',').map { |a| a.strip }
      end

      # Override Rack 0.9.x's #params implementation (see #72 in lighthouse)
      def params
        self.GET.update(self.POST)
      rescue EOFError, Errno::ESPIPE
        self.GET
      end
    end
    
    class Response < Rack::Response
      
    end
    
  end
end