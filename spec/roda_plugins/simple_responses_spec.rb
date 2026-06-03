require "roda"

RSpec.describe("simple_responses plugin") {
  include Rack::Test::Methods

  let(:app) {
    Class.new(Roda) {
      plugin :all_verbs
      plugin :simple_responses

      route { |r|
        r.on("resources") {
          r.post("absolute") { r.created("/resources/42") }
          r.post("relative") { r.created("7", relative: true) }
          r.post("with-headers") { r.created("/resources/42", headers: { "x-custom" => "value" }) }
          r.post("plain") { r.created }
          r.delete("gone") { r.deleted }
        }

        r.get("invalid") { r.bad_request("invalid payload") }
        r.get("missing") { r.not_found("nothing here") }
      }
    }
  }

  describe("#created") {
    it("returns 201 with an absolute location") {
      post "/resources/absolute"

      expect(last_response.status).to eq(201)
      expect(last_response.headers["location"]).to eq("/resources/42")
      expect(last_response.body).to be_empty
    }

    it("builds the location relative to the current path") {
      post "/resources/relative"

      expect(last_response.status).to eq(201)
      expect(last_response.headers["location"]).to eq("/resources/relative/7")
    }

    it("keeps the headers it receives") {
      post "/resources/with-headers"

      expect(last_response.status).to eq(201)
      expect(last_response.headers["x-custom"]).to eq("value")
      expect(last_response.headers["location"]).to eq("/resources/42")
    }

    it("omits the location header when no resource path is given") {
      post "/resources/plain"

      expect(last_response.status).to eq(201)
      expect(last_response.headers).not_to have_key("location")
    }
  }

  describe("#deleted") {
    it("returns 204 with an empty body") {
      delete "/resources/gone"

      expect(last_response.status).to eq(204)
      expect(last_response.body).to be_empty
    }
  }

  describe("#bad_request") {
    it("returns 400 with the given body") {
      get "/invalid"

      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq("invalid payload")
    }
  }

  describe("#not_found") {
    it("returns 404 with the given body") {
      get "/missing"

      expect(last_response.status).to eq(404)
      expect(last_response.body).to eq("nothing here")
    }
  }
}
