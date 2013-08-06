require_relative 'spec_helper'

class Post < ActiveRecord::Base
  include SimplePaginator
end

describe SimplePaginator do
  describe 'methods' do
    specify { expect(Post).to be_respond_to(:paged) }
    specify { expect(Post).to be_respond_to(:par_page) }
    specify { expect(Post).to be_respond_to(:max_page) }
  end
end