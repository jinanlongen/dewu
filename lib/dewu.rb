require "dewu/version"
require "dewu/sign"
require "dewu/service"

module Dewu
  SANDBOX_URL = "https://openapi-sandbox.dewu.com/dop/api/"
  PRODUCTION_URL = "https://openapi.dewu.com/dop/api/"

  class Error < StandardError; end

  @options = {}

  class << self
    attr_accessor :app_key, :app_secret, :base_uri
  end

  if ENV["DEWU_DEBUG"]
    self.app_key, self.app_secret, env_type = ENV["DEWU_DEBUG"].split(",")
    self.base_uri = env_type ? Dewu::PRODUCTION_URL : Dewu::SANDBOX_URL
  end
end
