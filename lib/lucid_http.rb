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
      define_method(verb.upcase) do |path, formatter: :plain, follower: :no_follow, form: {}|
        do_verb(
          verb: verb, path: path,
          formatter: formatter, follower: follower,
          form: form,
        )
      end
    end

    def do_verb(verb:, path:, formatter:, follower:, form:)
      LucidHttp::Response.new(
        base_url: base_url, path: path, verb: verb,
        formatter: formatter, follower: follower,
        form: form,
      )
    end
  end
end

%i[get post put patch delete options].each do |verb|
  define_method(verb.upcase) do |path, formatter: :plain, follower: :no_follow, form: {}|
    @__response = LucidHttp::Client.new(base_url: "http://localhost:9292").do_verb(
      verb: verb, path: path,
      formatter: formatter, follower: follower,
      form: form,
    )
    @__response.body
  end
end

def body
  @__response.body
end

def verb
  @__response.verb
end

def status
  @__response.status
end

def content_type
  @__response.content_type
end

def url
  @__response.url
end

def path
  @__response.path
end

def error
  @__response.error
end
