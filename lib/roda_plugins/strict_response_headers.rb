module RodaPlugins
  class StrictResponseHeaders
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)

      headers.each { |name, value|
        next if value.is_a?(String) || (value.is_a?(Array) && value.all?(String))

        raise "Header #{name} must be a String or Array of Strings, but the value is a #{value.class}"
      }

      [status, headers, body]
    end
  end
end
