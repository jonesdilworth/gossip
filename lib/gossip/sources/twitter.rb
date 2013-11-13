module Gossip
  class Twitter
    include Source

    def parse_response(response)
      MultiJson.load(response.body)['count']
    end

  protected

    def base_url
      'http://urls.api.twitter.com/1/urls/count.json'
    end

    def query_params
      { url: url }
    end
  end
end
