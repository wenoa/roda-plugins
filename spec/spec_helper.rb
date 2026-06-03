require "simplecov"
require "simplecov-console"

if ENV["COVERAGE"]
  SimpleCov.start {
    enable_coverage :branch
  }
end

require "rack/test"
require_relative "../lib/roda_plugins"
