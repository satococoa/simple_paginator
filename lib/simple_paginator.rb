require "simple_paginator/version"
require 'active_support/core_ext/class'
require 'active_support/concern'
require 'active_record'

module SimplePaginator
  extend ActiveSupport::Concern

  DEFAULT_PAR_PAGE = 20
  DEFAULT_MAX_PAGE = 10

  included do
    cattr_accessor :par_page, :max_page
    self.par_page = DEFAULT_PAR_PAGE
    self.max_page = DEFAULT_MAX_PAGE
    scope :paged, ->(page) {
      page_number = [page.to_i, 1].max # 最低でも 1
      if page_number > max_page
        none
      elsif page_number == max_page
        limit(par_page).offset((page_number-1)*par_page)
      else
        limit(par_page+1).offset((page_number-1)*par_page)
      end
    }
  end
end
