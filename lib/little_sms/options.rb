require "yaml"

class LittleSMS
  class Component
    # This module should be mixed with request options hash.
    #   to overwite Hash#sort method
    module Options
      class NoMethodError < StandardError; end
      class NoComponentError < StandardError; end
      attr_accessor :method_path
      def sort
        order = load_order(@method_path[:component], @method_path[:method])
        self.to_a.sort do |a,b|
          order.find_index(a[0]) <=> order.find_index(b[0])
        end
      end

      private
      # load sorting order from yaml file
      def load_order(component, method)
        begin
          order = YAML.load_file("#{File.dirname(__FILE__)}/ordering/#{component}.yaml")[method]
          raise NoMethodError, "There is no such method in #{component} file: #{method}" if order.nil?
          order
        rescue Errno::ENOENT
          raise NoComponentError, "There is no such file: #{component}"
        end
      end
    end
  end
end

