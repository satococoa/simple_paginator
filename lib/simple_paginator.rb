require "simple_paginator/version"
require 'active_record'

module SimplePaginator
  DEFAULT_PER_PAGE = 25
  DEFAULT_MAX_PAGE = 10

  def self.included(base)
    base.extend ClassMethods

    base.class_eval do
      per_page DEFAULT_PER_PAGE
      max_page DEFAULT_MAX_PAGE
    end
  end

  module ClassMethods
    def paged(page, options = {})
      num = page_number(page)
      per_page = options[:per_page].presence || @per_page
      if num > @max_page
        scoped = none
      elsif num == @max_page
        scoped = limit(per_page).offset((num-1)*per_page)
      else
        scoped = limit(per_page+1).offset((num-1)*per_page)
      end
      scoped
    end

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
