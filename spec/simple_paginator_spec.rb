require_relative 'spec_helper'

describe SimplePaginator do
  context 'Post includes SimplePaginator' do

    before do
      class Post < ActiveRecord::Base
        include SimplePaginator
      end
      ActiveRecord::Schema.define do
        self.verbose = false
        create_table :posts, :force => true do |t|
          t.string :text
        end
      end
    end

    describe 'class methods' do
      specify { expect(Post).to be_respond_to(:paged) }
      specify { expect(Post).to be_respond_to(:par_page) }
      specify { expect(Post).to be_respond_to(:max_page) }
    end

    describe '.paged' do
      context 'page = 1' do
        let(:page) { 1 }
        it 'send :limit, :offset method' do
          Post.should_receive(:limit).with(26).once { Post }
          Post.should_receive(:offset).with(0).once
          Post.paged(page)
        end
      end
      context 'page = 2' do
        let(:page) { 2 }
        it 'send :limit, :offset method' do
          Post.should_receive(:limit).with(26).once { Post }
          Post.should_receive(:offset).with(25).once
          Post.paged(page)
        end
      end
      context 'page = 10' do
        let(:page) { 10 }
        it 'send :limit, :offset method' do
          Post.should_receive(:limit).with(25).once { Post }
          Post.should_receive(:offset).with(25 * (page-1)).once
          Post.paged(page)
        end
      end
      context 'page = 11' do
        let(:page) { 11 }
        it 'send :none method' do
          Post.should_receive(:none).once
          Post.paged(page)
        end
      end
    end
  end
end