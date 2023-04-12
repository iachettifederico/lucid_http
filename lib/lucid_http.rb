require "lucid_http/version"
require "http"
require "lucid_http/followers"
require "lucid_http/formatters"
require "lucid_http/response"

module LucidHttp
  def self.base_url
    @base_url || "http://localhost:9292"
  end

  def self.base_url=(new_base_url)
    @base_url = new_base_url
  end

  def self.reset_default_base_url!
    self.base_url = nil
  end

  class Client
    def initialize(base_url: ENV.fetch("LUCID_HTTP_BASE_URL"))
      LucidHttp.base_url = base_url
    end

    def base_url
      LucidHttp.base_url
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

def response
  @__response
end

def body
  response.body
end

def verb
  response.verb
end

def status
  response.status
end

def content_type
  response.content_type
end

def url
  response.url
end

def path
  response.path
end

def error
  response.error
end
