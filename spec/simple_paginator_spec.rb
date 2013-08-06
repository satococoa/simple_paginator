require_relative 'spec_helper'

describe SimplePaginator do
  describe 'defined?' do
    it 'SimplePaginatorが定義されている' do
      expect(defined?(SimplePaginator)).to eq('constant')
    end
  end
end