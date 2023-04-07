require "lucid_http/version"
require "http"
require "lucid_http/followers"
require "lucid_http/formatters"
require "lucid_http/response"

module LucidHttp
  class Client
    attr_reader :base_url

    def initialize(base_url:)
      @base_url = base_url
    end

    %i[get post put patch delete options].each do |verb|
      define_method(verb.upcase) do |path, formatter: :plain, follower: :no_follow|
        do_verb(verb: verb, path: path, formatter: formatter, follower: follower)
      end

    end

    def do_verb(verb:, path:, formatter:, follower:)
      LucidHttp::Response.new(
        base_url: base_url, path: path, verb: verb,
        formatter: formatter, follower: follower,
      )
    end

  end
end
