require "json"
module LucidHttp

  module Formatter

    def  self.for(keyword)
      {
        plain: PlainFormatter.new,
        json:  JsonFormatter.new,
      }.fetch(keyword)
    end

    class PlainFormatter
      def call(response_body)
        response_body
      end
    end

    class JsonFormatter
      def call(response_body)
        JSON.parse(response_body)
      end
    end
  end

end
