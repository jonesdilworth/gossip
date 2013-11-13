module Gossip
  class Runner
    attr_accessor :url, :sources

    def initialize(url, sources)
      self.url = url
      self.sources = constantize_sources(sources)
    end

    # TODO: Refactor and handle exceptions
    def fetch
      hydra = Typhoeus::Hydra.hydra

      share_data = sources.reduce({}) do |results, source|
        # initialize the source
        instance = source.new(url)
        # get a request
        instance.request.tap do |request|

          # set the oncomplete handler
          request.on_complete { |response|

            # parse response and add to results
            results[instance.name.downcase] = instance.parse_response(response)
          }

          # queue request
          hydra.queue(request)
        end

        results
      end

      hydra.run

      # FIXME: this code doesn't communicate resulting format well
      share_data.with_indifferent_access
    end

  protected

    def constantize_sources(sources)
      sources.map do |source|
        Gossip.const_get(source.to_s.classify)
      end
    end
  end
end
