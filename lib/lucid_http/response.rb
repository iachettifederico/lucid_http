module LucidHttp
  class Response
    attr_reader :base_url
    attr_reader :path

    def initialize(base_url:, path:, formatter:, follower:, verb: :get, form: {})
      @base_url  = base_url
      @path      = path
      @formatter = LucidHttp::Formatter.for(formatter)
      @follower  = LucidHttp::Follower.for(follower).client
      @verb      = verb
      @form      = form

      @response = @follower.send(@verb, url, params: form)
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
      body.split("\n").first || "No error found"
    end

    def verb
      @verb.to_s.upcase
    end
  end
end
