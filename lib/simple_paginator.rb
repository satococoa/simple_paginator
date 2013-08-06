require "simple_paginator/version"
require 'active_support/core_ext/class'
require 'active_support/concern'
require 'active_record'

module SimplePaginator
  extend ActiveSupport::Concern

  DEFAULT_PAR_PAGE = 25
  DEFAULT_MAX_PAGE = 10

  included do
    cattr_accessor :par_page, :max_page
    self.par_page = DEFAULT_PAR_PAGE
    self.max_page = DEFAULT_MAX_PAGE
    scope :paged, ->(page) {
      num = page_number(page)
      if num > max_page
        none
      elsif num == max_page
        limit(par_page).offset((num-1)*par_page)
      else
        limit(par_page+1).offset((num-1)*par_page)
      end
    }
  end

  module ClassMethods
    def page_number(raw_page)
      [raw_page.to_i, 1].max
    end
    def set_par_page(par_page)
      self.par_page = par_page
    end
    def set_max_page(max_page)
      self.max_page = max_page
    end
  end
end
