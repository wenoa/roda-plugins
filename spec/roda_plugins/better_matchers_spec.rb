require "roda"
require "date"

RSpec.describe("better_matchers plugin") {
  include Rack::Test::Methods

  context("String") {
    let(:app) {
      Class.new(Roda) {
        plugin :better_matchers
        route { |r| r.get(String) { |value| "#{value}:#{value.class}" } }
      }
    }

    it("matches a path segment and URL-decodes it") {
      get "/hello%20world"

      expect(last_response.body).to eq("hello world:String")
    }
  }

  context("Float") {
    let(:app) {
      Class.new(Roda) {
        plugin :better_matchers
        route { |r| r.get(Float) { |value| "#{value}:#{value.class}" } }
      }
    }

    it("matches a numeric segment and casts it to Float") {
      get "/3.14"

      expect(last_response.body).to eq("3.14:Float")
    }
  }

  context("Date") {
    let(:app) {
      Class.new(Roda) {
        plugin :better_matchers
        route { |r| r.get(Date) { |value| "#{value.iso8601}:#{value.class}" } }
      }
    }

    it("matches a YYYY-MM-DD segment and builds a Date") {
      get "/2026-07-06"

      expect(last_response.body).to eq("2026-07-06:Date")
    }
  }
}
