module Gossip
  class Pinterest
    include Source

    def parse_response(response)
      MultiJson.load(response.body[/\((.*)\)$/, 1])['count']
    end

  protected

    def base_url
      'http://api.pinterest.com/v1/urls/count.json'
    end

    def query_params
      { url: url }
    end
  end
end
