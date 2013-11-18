require 'set'
require 'cgi'

require 'multi_json'
require 'typhoeus'
require 'active_support/inflector' # for constantize & classify
require 'active_support/core_ext/hash' # for #deep_merge

require "gossip/runner"
require "gossip/source"

# Load sources
Gem.find_files("gossip/sources/*.rb").each { |path| require path }

module Gossip
  # Register all sources by default
  @@sources = Set.new([:facebook, :twitter, :google_plus, :linkedin, :pinterest])

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
