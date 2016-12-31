require "lucid_http/version"
require "http"
require "delegate"
require "json"

module LucidHttp
  def self.target_url(url="http://localhost:9292")
    @target_url ||= url
  end

  def self.target_url=(url="http://localhost:9292")
    @target_url = url
  end

  class PrettyStatus < SimpleDelegator
    def inspect
      to_s
    end
  end
end

def response
  @__lucid_http__res
end

def __lucid_http__clean
  instance_variables.grep(/@__lucid_http__/).each do |v|
    remove_instance_variable(v.to_sym)
  end
end

def __lucid_http__setup(url, action: :get, follow: false, form: nil, json: false, **opts)
  __lucid_http__clean
  @__lucid_http__client = HTTP.persistent(LucidHttp.target_url)
  if follow
    @__lucid_http__client = @__lucid_http__client.follow
  end
  @__lucid_http__path = @__lucid_http__client.default_options.persistent + url
  @__lucid_http__res = @__lucid_http__client.send(action.to_sym, url, form: form)
  @__lucid_http__json = json
end

def body
  @__lucid_http__body ||= __lucid_http__get_body
end

def __lucid_http__get_body
  original_body = response.body.to_s
  if !@__lucid_http__json
    original_body
  else
    JSON.parse(original_body)
  end
end

def status
  @__lucid_http__status = LucidHttp::PrettyStatus.new(response.status)
end

def content_type
  response.content_type.mime_type
end

def path
  @__lucid_http__path
end

def error
  if status.to_i == 500
    body.split("\n").first
  else
    "No 500 error found."
  end
end

def GET(url, **opts)
  __lucid_http__setup(url, **opts)
  new_body = case status.to_i
             when 200
               body
             else
               "STATUS: #{status}"
             end

  new_body
end

def POST(url, **opts)
  __lucid_http__setup(url, action: :post, **opts)
  new_body = case status.to_i
             when 200
               body
             else
               "STATUS: #{status}"
             end

  new_body
end
