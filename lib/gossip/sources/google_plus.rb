require 'nokogiri'

module Gossip
  class GooglePlus
    include Source

    def parse_response(response)
      Nokogiri::HTML(response.body).css('#aggregateCount').text.to_i
    end

  protected

    def base_url
      "https://plusone.google.com/_/+1/fastbutton?url=#{escaped_url}&count=true"
    end

    def headers
      {}
    end
  end
end
