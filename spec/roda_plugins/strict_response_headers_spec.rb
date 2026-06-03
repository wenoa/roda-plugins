RSpec.describe("StrictResponseHeaders middleware") {
  let(:downstream) { ->(_env) { [200, headers, ["body"]] } }
  let(:middleware) { RodaPlugins::StrictResponseHeaders.new(downstream) }

  context("with string and string-array headers") {
    let(:headers) { { "content-type" => "text/plain", "set-cookie" => ["a", "b"] } }

    it("passes the response through unchanged") {
      expect(middleware.call({})).to eq([200, headers, ["body"]])
    }
  }

  context("with a non-string header value") {
    let(:headers) { { "x-count" => 3 } }

    it("raises describing the offending header") {
      expect { middleware.call({}) }.to raise_error(/x-count must be a String or Array of Strings.*Integer/)
    }
  }

  context("with an array header holding a non-string") {
    let(:headers) { { "x-mixed" => ["ok", 1] } }

    it("raises describing the offending header") {
      expect { middleware.call({}) }.to raise_error(/x-mixed must be a String or Array of Strings.*Array/)
    }
  }
}
