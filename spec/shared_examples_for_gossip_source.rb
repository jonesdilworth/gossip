shared_examples "a gossip source" do
  let(:url) { 'http://techcrunch.com/' }
  let(:source) { described_class.new(url) }

  describe '#name' do
    it 'returns a name for the source' do
      expect(source.name).to be_a String
    end
  end

  describe '#request' do
    it 'returns a Typhoeus request' do
      expect(source.request).to be_an_instance_of Typhoeus::Request
    end
  end

  describe '#parse_response' do
    let(:request) { source.request }
    let(:response) { request.run }

    it 'parses a response' do
      expect(source.parse_response(response)).to be_a Fixnum
    end
  end
end
