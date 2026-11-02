require "roda"

class Roda
  module RodaPlugins
    module SimpleResponses
      module RequestMethods
        def created(path_to_resource = "", headers: {}, relative: false)
          unless path_to_resource.to_s.empty?
            headers["location"] = relative ? File.join(path, path_to_resource) : path_to_resource
          end
          throw :halt, [201, response.headers.merge(headers), []]
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
          throw :halt, [204, response.headers, []]
        end
      end
    end

    register_plugin(:simple_responses, SimpleResponses)
  end
end
