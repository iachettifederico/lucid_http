module LucidHttp
  module Follower
    class NoFollow
      def get(url)
        HTTP.get(url)
      end
    end
  end

  module Follower
    class Follow
      def get(url)
        HTTP.follow.get(url)
      end
    end
  end
end
