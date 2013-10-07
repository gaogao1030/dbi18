# -*- encoding : utf-8 -*-
module Dbi18
  module Configure

    LOCALE = [:en,:zh]
    attr_accessor :locale
    
    attr_accessor :model

    def configure
      yield self if block_given?

      self.locale ||= LOCALE

    end
  
  end
end
