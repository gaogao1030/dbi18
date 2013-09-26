module Dbi18
  module Configure

    ATTRIBUTES = :name,:des
  	attr_accessor :attributes

    LANGUAGE_TYPE = [:en,:zh]
    attr_accessor :language_type

    def configure
      yield self if block_given?

      self.attributes ||= ATTRIBUTES
      self.language_type ||= LANGUAGE_TYPE

    end
  
  end
end