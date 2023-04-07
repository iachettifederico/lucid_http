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

    def GET(path,
            formatter: LucidHttp::Formatter::PlainFormatter.new,
            follower: LucidHttp::Follower::NoFollow.new)
      LucidHttp::Response.new(
        base_url: base_url, path: path,
        formatter: formatter, follower: follower,
      )
    end
  end
end
