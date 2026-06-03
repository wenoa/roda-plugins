# Roda Plugins

```ruby
gem "roda_plugins", github: "wenoa/roda-plugins"
```

```ruby
require "roda_plugins" # or require each plugin under "roda_plugins/"
```

- `better_matchers` — routing class matchers for `String`, `Float` and `Date`.
- `simple_responses` — `created`, `deleted`, `bad_request`, `not_found` request helpers.
- `RodaPlugins::StrictResponseHeaders` — Rack middleware that fails when a response header is not a String or Array of Strings.
