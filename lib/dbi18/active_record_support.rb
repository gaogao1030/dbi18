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
			models_sym = Dbi18.model.to_s.pluralize.downcase.to_sym
			self.class_eval do
			  has_many models_sym, :as => :classtable
			end
			init_attr_method = ("init_hash_content").to_sym
			self.send :define_method, init_attr_method do #initial obeject.dbi18_type.hash_content
	  		@count = 0
	  		p (attributes.length * language.length)
	  		attributes.each do |attrs|
	  			language.each do |l_type|
		  			attrs_locale = attrs.to_s + "_" + l_type.to_s
		  			@count += 1
		  			if @count == 1
		  				@str = "{"
		  			end

		  			if @count < (attributes.length * language.length)
		  				p @count
		  				@str += "\"#{attrs_locale}\"=>\"\","
		  			else
		  				@str += "\"#{attrs_locale}\"=>\"\"}"
		  			end
	  			end
	  		end
	  		return @str
	  	end

		  save_method = "save".to_sym
		  self.send :define_method, save_method do
		  	models = self.send models_sym
		  	if !models.blank?
					models.each do |model|
						if model.locale == l_type
							hash = eval "self.send #{init_attr_method}" if model.hash_content.blank?
							hash["#{attrs_locale}"] = self.(attrs_locale.to_sym)
							model.hash_content = hash.to_s
							model.classtable = self
							model.save
						end
					end
				else
					new_model = (Dbi18.model).new
					hash = eval "self.send #{init_attr_method}"
					model.hash_content = hash.to_s
					new_model.classtable = self
					new_model.save
				end
			end

			attributes.each do |attrs|
				language.each do |l_type|
					attrs_locale = attrs.to_s + "_" + l_type.to_s
					p attrs_locale
						self.class_eval do
						  attr_accessor attrs_locale.to_sym
						end
						# attribute = attrs.to_s
						# locale = l_type.to_s
						# new_method = attribute+"_"+locale+"="
						# new_method = new_method.to_sym
						# self.send :define_method, new_method do |args| #set_value
						# 		if (self.send models_sym).blank?
						# 			hash = eval "self.send #{init_attr_method}"
						# 		end

					 #    end

						# 	new_method = attrs.to_s+"_"+l_type.to_s
						# 	new_method = new_method.to_sym
					 #    self.send :define_method, new_method do #get_value
					 #      eval(
				  #   			"
				  #     	 	self.#{dbi18_type} = (Dbi18.model).where(:class_id => self.id, :class_name => self.class.name, :locale => locale).first if self.#{dbi18_type}.blank?;
				  #     	 	return \"\" if (self.#{dbi18_type}).blank?;
				  #     	 	return \"\" if (self.#{dbi18_type}.hash_content).blank?;
				  #     	 	return  (eval self.#{dbi18_type}.hash_content)[\"#{attribute}\"]
				  #     	 	"
					 #      	 	)
						#     end

						end
					end

				# self.send :define_method, attrs do #get_value_with_i18n.locale
		  #   	locale = I18n.locale.to_s
		  #   		self.send  attrs.to_s+"_"+locale
		  #   end

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