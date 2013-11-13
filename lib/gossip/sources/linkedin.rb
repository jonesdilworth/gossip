module Gossip
  class Linkedin
    include Source

    def parse_response(response)
      MultiJson.load(response.body)['count']
    end

  protected

    def base_url
      'http://www.linkedin.com/countserv/count/share'
    end

    def query_params
      { url: url, format: 'json' }
    end
  end
end
