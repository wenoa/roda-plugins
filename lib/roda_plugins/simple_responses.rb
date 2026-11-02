require "roda"

class Roda
  module RodaPlugins
    module SimpleResponses
      def self.load_dependencies(app, _opts = {})
        app.plugin :halt
      end

      module RequestMethods
        def created(path_to_resource = "", headers: {}, relative: false)
          unless path_to_resource.to_s.empty?
            headers["location"] = relative ? File.join(path, path_to_resource) : path_to_resource
          end
          response.headers.merge!(headers)
          halt(201)
        end

        def bad_request(body)
          response.status = 400
          response.write(body)
        end

        def not_found(body)
          response.status = 404
          response.write(body)
        end

        def deleted
          halt(204)
        end
      end
    end

    register_plugin(:simple_responses, SimpleResponses)
  end
end
