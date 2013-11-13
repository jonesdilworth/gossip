module Gossip
  class Facebook
    include Source

    def parse_response(response)
      MultiJson.load(response.body)['data'].first['total_count']
    rescue NoMethodError
      raise UnexpectedResponse
    end

  protected

    def base_url
      'https://graph.facebook.com/fql'
    end

    def query_params
      { q: query }
    end

    def query
      # TODO: I think this needs to be escaped before it gets used in the request
      %{SELECT total_count FROM link_stat WHERE url="#{escaped_url}"}
    end
  end
end
