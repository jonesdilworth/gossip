require 'multi_json'
require 'typhoeus'
require 'set'
require 'active_support/inflector' # for constantize & classify

require "gossip/runner"
require "gossip/source"

# Load sources
Gem.find_files("gossip/sources/*.rb").each { |path| require path }

module Gossip
  @@sources = Set.new

  def self.default_sources=(*sources)
    @@sources = Set.new(sources.flatten)
  end

  def self.default_sources
    @@sources
  end

  def self.shares_for(url, options = {})
    options.reverse_merge!(sources: default_sources)

    Runner.new(
      url,
      options[:sources]
    ).fetch
  end

  def self.shares_from(source, url)
    shares_for(url, sources: [ source ]).fetch(source)
  end

  class RequestFailure < StandardError; end
  class UnexpectedResponse < StandardError; end
  class NotImplemented < StandardError; end
end


# Example API, until docs are present:
# Gossip.shares_for('asdasd') #=> { source1: 123, source2: 321, ... }
# Gossip.shares_from(:facebook, 'url') #=> 123
# Gossip.shares_for('asdsad', sources: [:facebook, :twitter]) #=> { twitter: 123, facebook: 321 }
# Gossip.default_sources = [:facebook, :twitter]
