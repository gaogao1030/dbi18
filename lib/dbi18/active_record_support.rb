# -*- encoding : utf-8 -*-
module Dbi18
	module ActiveRecordSupport
		def self.included(base)
  		base.extend ClassMethods
  	end
  end

module ClassMethods

	def db_i18n(*attributes)
		include Del
		language = Dbi18.locale
		self.class_eval do
			alias :old_save :save
		end
		self.send :define_method, "save" do
			if self.old_save
				language.each do |l_type|
					locale = l_type.to_s
						if ((Dbi18.model).where(:class_id => self.id, :class_name => self.class.name, :locale => locale).first).blank?
							model = (Dbi18.model).new
							model.hash_content = self.init_hash_content
						else
							model = (Dbi18.model).where(:class_id => self.id, :class_name => self.class.name, :locale => locale).first
						end
						hash_content = eval model.hash_content
						attributes.each do |attrs|
							attrs_locale = attrs.to_s + "_" + l_type.to_s
							attrs_locale_sym = attrs_locale.to_sym
							hash_content["#{attrs}"]= self.send attrs_locale_sym
						end
							model.class_id = self.id
							model.class_name = self.class.name
							model.locale = locale
							model.hash_content = hash_content.to_s
							model.save
					end
			end
	  end

  	init_attr_method = ("init_hash_content").to_sym
	  	self.send :define_method, init_attr_method do #initial obeject.dbi18_type.hash_content
	  		@count = 0
	  		attributes.each do |attrs|
	  			attrs = attrs.to_s
	  			@count += 1
	  			if @count == 1
	  				@str = "{"
	  			end
	  			if @count < attributes.length
	  				@str += "\"#{attrs}\"=>\"\","
	  			else
	  				@str += "\"#{attrs}\"=>\"\"}"
	  			end
	  		end
	  		return @str
	  	end

		attributes.each do |attrs|
			language.each do |l_type| 
				attrs_locale = attrs.to_s + "_" + l_type.to_s
						self.class_eval do
						  attr_accessor attrs_locale.to_sym
						end
						# get_method = attrs.to_s+"_"+l_type.to_s
						# get_method = get_method.to_sym
				  #   self.send :define_method, get_method do #get_value

						# end
					end
			self.send :define_method, attrs do #get_value_with_i18n.locale
	    	locale = I18n.locale.to_s
	    		self.send  attrs.to_s+"_"+locale
	    end
	end



	end
end

	module Del
		def delete
			if !(@s_result = (Dbi18.model).where(:class_id => self.id, :class_name => self.class.name)).blank?
				@s_result.each do |result|
					result.delete
				end
			end
			super
		end
	end
end
