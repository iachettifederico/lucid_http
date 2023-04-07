module LucidHttp

  module Follower

    def self.for(keyword)
      {
        no_follow: NoFollow.new,
        follow:    Follow.new,
      }.fetch(keyword)
    end

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
