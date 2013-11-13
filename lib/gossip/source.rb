require 'active_support/core_ext/hash' # for #deep_merge

module Gossip
  module Source
    attr_accessor :url

    def initialize(url)
      self.url = url
    end

    def name
      self.class.name[/::([a-zA-Z]+)/, 1]
    end

    def request
      Typhoeus::Request.new(
        base_url,
        { params: query_params }.deep_merge!(request_options)
      )
    end

    def parse_response(response)
      raise NotImplemented
    end

  protected

    def request_options
      { method: request_method, headers: headers }
    end

    def request_method
      :get
    end

    def headers
      { 'Accept' => 'text/json' }
    end
  end
end
