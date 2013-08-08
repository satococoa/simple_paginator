require "simple_paginator/version"
require 'active_support/core_ext/class'
require 'active_support/concern'
require 'active_record'

module SimplePaginator
  extend ActiveSupport::Concern

  DEFAULT_PER_PAGE = 25
  DEFAULT_MAX_PAGE = 10

  included do
    per_page DEFAULT_PER_PAGE
    max_page DEFAULT_MAX_PAGE
    scope :paged, ->(page) {
      num = page_number(page)
      if num > @max_page
        none
      elsif num == @max_page
        limit(@per_page).offset((num-1)*@per_page)
      else
        limit(@per_page+1).offset((num-1)*@per_page)
      end
    }
  end

  module ClassMethods
    def page_number(raw_page)
      [raw_page.to_i, 1].max
    end
    def per_page(per_page)
      @per_page = per_page
    end
    def max_page(max_page)
      @max_page = max_page
    end
  end
end
