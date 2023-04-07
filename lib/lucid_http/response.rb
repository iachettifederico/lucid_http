module LucidHttp
  class Response
    attr_reader :base_url
    attr_reader :path

    def initialize(base_url:, path:, formatter:, follower:)
      @base_url  = base_url
      @path      = path
      @formatter = formatter

      @response = follower.get(url)
    end

    def body
      @formatter.call(@response.body.to_s)
    end

    def status
      @response.status.to_s
    end

    def content_type
      @response.content_type.mime_type
    end

    def url
      "#{base_url}#{path}"
    end

    def error
      body.split("\n").first
    end
  end
end
