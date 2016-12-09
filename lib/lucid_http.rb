require "lucid_http/version"
require "http"

module LucidHttp
  def response
    @res
  end

  def _clean
    @client = nil
    @res    = nil
    @body   = nil
    @path   = nil
  end

  def _setup(url, action: :get, follow: false, form: nil, **opts)
    _clean
    @client = HTTP.persistent("http://localhost:9292")
    if follow
      @client = @client.follow
    end
    @path = @client.default_options.persistent + url
    @res = @client.send(action.to_sym, url, form: form)
  end

  def body
    @body ||= response.body.to_s
  end

  def status
    @status = response.status
  end

  def content_type
    response.content_type.mime_type
  end

  def path
    @path
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
