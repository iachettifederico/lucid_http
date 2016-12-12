require "lucid_http/version"
require "http"

module LucidHttp
  def response
    @__lucid_http__res
  end

  def _clean
    instance_variables.grep(/@_lucid_http_/).each do |v|
      remove_instance_variable(v)
    end
  end

  def _setup(url, action: :get, follow: false, form: nil, **opts)
    _clean
    @__lucid_http__client = HTTP.persistent("http://localhost:9292")
    if follow
      @__lucid_http__client = @__lucid_http__client.follow
    end
    @__lucid_http__path = @__lucid_http__client.default_options.persistent + url
    @__lucid_http__res = @__lucid_http__client.send(action.to_sym, url, form: form)
  end

  def body
    @__lucid_http__body ||= response.body.to_s
  end

  def status
    @__lucid_http__status = response.status
  end

  def content_type
    response.content_type.mime_type
  end

  def path
    @__lucid_http__path
  end

  def GET(url, **opts)
    _setup(url, **opts)
    new_body = case status.to_i
               when 200
                 body
               when 500
                 body.each_line.first
               else
                 "ERROR: #{status.to_s}"
               end

    # puts new_body
    new_body
  end

  def POST(url, **opts)
    _setup(url, action: :post, **opts)
    body
  end
end
