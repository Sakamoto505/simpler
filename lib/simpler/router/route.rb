module Simpler
  class Router
    class Route

      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
      end



      def match?(method, path)
        @method == method && correct_request(path)
      end

      def correct_request(path)
        different_path(path) && path =~ path_to_route
      end

      def different_path(path)
        requested_path = path.split('/')
        route_path = @path.split('/')
        requested_path.count == route_path.count
      end

      def path_to_route
        Regexp.new("^#{@path.gsub(/:id/, '\d+')}$")
      end

    end
  end
end
