module Dbi18
  module Configure

    LANGUAGE_TYPE = [:en,:zh]
    attr_accessor :language_type
    
    attr_accessor :model

    def configure
      yield self if block_given?

      self.language_type ||= LANGUAGE_TYPE

    end
  
  end
end