module LucidHttp

  module Follower
    class NoFollow
      def client
        HTTP
      end
    end

    class Follow
      def client
        HTTP.follow
      end
    end
  end

end
