use Mix.Config

config :mailchimp,
  api_key: "your apikey-us19",
  http_options: [
    # `HTTPoison.Request` options
    timeout: 8_000,
    recv_timeout: 5_000
  ]

import_config "#{Mix.env()}.exs"
