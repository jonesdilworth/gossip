require 'spec_helper'
require 'shared_examples_for_gossip_source'

describe Gossip::Twitter do
  it_behaves_like 'a gossip source'
end
