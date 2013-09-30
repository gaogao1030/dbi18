module Dbi18
  module Configure

    locale = [:en,:zh]
    attr_accessor :locale
    
    attr_accessor :model

    def configure
      yield self if block_given?

      self.locale ||= locale

    end
  
  end
end