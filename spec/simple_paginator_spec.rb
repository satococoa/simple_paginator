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
      specify { expect(Post).to be_respond_to(:per_page) }
      specify { expect(Post).to be_respond_to(:max_page) }
    end

    describe '.page_number' do
      subject(:page_number) { Post.page_number(raw_page) }
      context 'raw_page is string' do
        let(:raw_page) { 'foo' }
        specify { expect(subject).to eq(1) }
      end
      context 'raw_page is blank string' do
        let(:raw_page) { '' }
        specify { expect(subject).to eq(1) }
      end
      context 'raw_page is 0' do
        let(:raw_page) { 0 }
        specify { expect(subject).to eq(1) }
      end
      context 'raw_page is negative' do
        let(:raw_page) { -1 }
        specify { expect(subject).to eq(1) }
      end
      context 'raw_page is a string to represent number' do
        let(:raw_page) { '10' }
        specify { expect(subject).to eq(10) }
      end
      context 'raw_page is a string to represent negative number' do
        let(:raw_page) { '-1' }
        specify { expect(subject).to eq(1) }
      end
      context 'raw_page is nil' do
        let(:raw_page) { nil }
        specify { expect(subject).to eq(1) }
      end
    end

    describe '.paged' do
      context 'per_page, max_page are default' do
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

      context 'change per_page, max_page' do
        before do
          Post.class_eval {
            per_page 3
            max_page 2
          }
        end

        after do
          Post.class_eval {
            per_page SimplePaginator::DEFAULT_PER_PAGE
            max_page SimplePaginator::DEFAULT_MAX_PAGE
          }
        end

        context 'page = 1' do
          let(:page) { 1 }
          it 'send :limit, :offset method' do
            Post.should_receive(:limit).with(4).once { Post }
            Post.should_receive(:offset).with(0).once
            Post.paged(page)
          end
        end
        context 'page = 2' do
          let(:page) { 2 }
          it 'send :limit, :offset method' do
            Post.should_receive(:limit).with(3).once { Post }
            Post.should_receive(:offset).with(3).once
            Post.paged(page)
          end
        end
        context 'page = 3' do
          let(:page) { 3 }
          it 'send :limit, :offset method' do
            Post.should_receive(:none).once
            Post.paged(page)
          end
        end
      end
    end
  end
end