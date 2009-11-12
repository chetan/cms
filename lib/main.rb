
module Pixelcop
  
  class Main
    
    CALLERS_TO_IGNORE = [
      /web\/server.ru/,      # all sinatra code
      /\(.*\)/,              # generated code
      /custom_require\.rb$/, # rubygems require hacks
      /active_support/,      # active_support require hacks
    ] unless self.const_defined?('CALLERS_TO_IGNORE')

    # add rubinius (and hopefully other VM impls) ignore patterns ...
    CALLERS_TO_IGNORE.concat(RUBY_IGNORE_CALLERS) if defined?(RUBY_IGNORE_CALLERS)

    # Like Kernel#caller but excluding certain magic entries and without
    # line / method information; the resulting array contains filenames only.
    def self.caller_files
      caller_locations.
        map { |file,line| file }
    end

    def self.caller_locations
      caller(1).
        map    { |line| line.split(/:(?=\d|in )/)[0,2] }.
        reject { |file,line| CALLERS_TO_IGNORE.any? { |pattern| file =~ pattern } }
    end
    
  end # Main
end # Pixelcop