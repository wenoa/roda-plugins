require "roda"
require "date"
require "uri"

class Roda
  module RodaPlugins
    module BetterMatchers
      def self.load_dependencies(app)
        app.plugin :class_matchers
      end

      def self.configure(app)
        app.class_matcher(String, %r{(.*?)(?=/|$)}) { |value| [URI.decode_www_form_component(value)] }
        app.class_matcher(Float, /([\d.]*)/) { |value| [value.to_f] }
        app.class_matcher(Date, /(\d\d\d\d)-(\d\d)-(\d\d)/) { |y, m, d| [Date.new(y.to_i, m.to_i, d.to_i)] }
      end
    end

    register_plugin(:better_matchers, BetterMatchers)
  end
end
