Airbrake.configure do |config|
  config.api_key = Settings["errors.key"]
  config.host    = Settings["errors.host"]
end
