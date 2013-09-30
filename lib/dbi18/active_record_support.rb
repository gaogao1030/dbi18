module Dbi18
	module ActiveRecordSupport
		def self.included(base)
  		base.extend ClassMethods
  	end

module ClassMethods

	def db_i18n(*attributes)
		# include Del
		language = Dbi18.locale
		# models_sym = Dbi18.model.to_s.pluralize.to_sym
		# self.class_eval do
		#   has_many models_sym
		# end
	 #  save_method = "save".to_sym
	 #  self.send :define_method, save_method do
	 #  	models_sym = Dbi18.model.to_s.pluralize.to_sym
	 #  	models = self.send models_sym
		# 	models.each do |model|
		# 		if model.locale == l_type
		# 			hash = eval "self.send #{init_attr_method}" if model.hash_content.blank?
		# 			hash["#{attrs_locale}"] = self.(attrs_locale.to_sym)
		# 		end
		# 	end
		# end

  	# init_attr_method = ("init_hash_content").to_sym
	  # 	self.send :define_method, init_attr_method do #initial obeject.dbi18_type.hash_content
	  # 		@count = 0
	  # 		attributes.each do |attrs|
	  # 			language.each do |l_type|
	  # 			attrs_locale = attrs.to_s + l_type.to_s
	  # 			@count += 1
	  # 			if @count == 1
	  # 				@str = "{"
	  # 			end
	  # 			if @count < attributes.length
	  # 				@str += "\"#{attrs_locale}\"=>\"\","
	  # 			else
	  # 				@str += "\"#{attrs_locale}\"=>\"\"}"
	  # 			end
	  # 		end
	  # 		return @str
	  # 	end
	  # end

		attributes.each do |attrs|
			language.each do |l_type|
				attrs_locale = attrs.to_s + l_type.to_s
				p attrs_locale
					self.class_eval do
					  attr_accessor attrs_locale.to_sym
					end
					attribute = attrs.to_s
					locale = l_type.to_s
					new_method = attribute+"_"+locale+"="
					new_method = new_method.to_sym
					dbi18_type = ("dbi18_"+locale).to_sym
					self.send :define_method, new_method do |args| #set_value
						if eval("self.#{dbi18_type}.blank?")
				    	@s_result = (Dbi18.model).new if ((@s_result = (Dbi18.model).where(:class_id => self.id, :class_name => self.class.name, :locale => locale).first).blank?)
				    else
				    	eval("@s_result = self.#{dbi18_type}")
				    end
				    	result = self.send "#{init_attr_method}" if @s_result.hash_content.blank?
				    	result = @s_result.hash_content.to_s if !@s_result.hash_content.blank?
				    	# j_result = JSON.parse result
				    	hash_result = eval result
				    	hash_result["#{attrs}"] = "#{args}"
				    	@s_result.class_id = self.id#obj.id 
				    	@s_result.class_name = self.class.name #obj.class.name
				    	@s_result.locale = locale
				    	@s_result.hash_content = hash_result.to_s
				    	eval("self.#{dbi18_type} = @s_result")
				    end
						new_method = attrs.to_s+"_"+l_type.to_s
						new_method = new_method.to_sym
				    self.send :define_method, new_method do #get_value
				      eval(
			    			"
			      	 	self.#{dbi18_type} = (Dbi18.model).where(:class_id => self.id, :class_name => self.class.name, :locale => locale).first if self.#{dbi18_type}.blank?;
			      	 	return \"\" if (self.#{dbi18_type}).blank?;
			      	 	return \"\" if (self.#{dbi18_type}.hash_content).blank?;
			      	 	return  (eval self.#{dbi18_type}.hash_content)[\"#{attribute}\"]
			      	 	"
				      	 	)
					    end
					end
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