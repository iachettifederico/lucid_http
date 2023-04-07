require "json"
module LucidHttp

  module Formatter
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
