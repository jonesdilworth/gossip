require 'spec_helper'

describe Gossip do
  let(:url) { 'http://www.cnn.com/2013/06/14/world/europe/london-underground-lego/index.html'}
  let(:gossip) { Gossip }

  it 'responds to #shares_for' do
    expect(gossip).to respond_to(:shares_for)
  end

  context "with at least one source" do
    before(:all) do
      Gossip.default_sources = [:twitter]
    end
    # it "has at least one source" do
    #   expect(gossip.sources).to have_at_least(1).item
    # end

    describe '#shares_for' do
      let(:response) { gossip.shares_for(url) }

      it 'responds with a hash' do
        expect(response).to be_a Hash
      end

      it 'has at least one responding source' do
        expect(response.count).to be >= 1
      end

      it 'returns numeric share counts' do
        expect(response.values.first).to be_a Fixnum
        expect(response[Gossip.default_sources.first]).to be_a Fixnum
      end
    end
  end

  context 'without any sources' do
    before do
      Gossip.default_sources = []
    end

    describe '#shares_for' do
      it 'does not have any results' do
        expect(gossip.shares_for(url)).to eq({})
      end
    end
  end
end
