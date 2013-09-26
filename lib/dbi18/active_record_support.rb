module Dbi18
	module ActiveRecordSupport
		def self.included(base)
  		base.extend ClassMethods
  	end

module ClassMethods
	def db_i18n(*attributes, language)
		include Del
		language.each do |l_type|
		s_l_type = l_type.to_s
		dbi18_type = ("dbi18_"+s_l_type).to_sym
		after_action = ("after"+"_"+dbi18_type.to_s).to_sym
			self.class_eval do
					  attr_accessor dbi18_type
					  after_save after_action
				end
		self.send :define_method, after_action do #after_save_action
				eval("
							if !self.#{dbi18_type}.blank?
								self.#{dbi18_type}.class_id = self.id;
								self.#{dbi18_type}.save;
							else
								self.#{dbi18_type} = CimuDbi18.new if (self.#{dbi18_type} = CimuDbi18.where(:class_id => self.id, :class_name => self.class.name, :property => method.to_s).first).blank?;
								self.#{dbi18_type}.class_id = self.id;
								self.#{dbi18_type}.property = method.to_s;
								self.#{dbi18_type}.class_name = self.class.name
								self.save
							end
							")
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
					attribute = attrs.to_s
					language_type = l_type.to_s
					new_method = attribute+"_"+language_type+"="
					new_method = new_method.to_sym
					dbi18_type = ("dbi18_"+language_type).to_sym
					self.send :define_method, new_method do |args| #set_value
						if eval("self.#{dbi18_type}.blank?")
				    	@s_result = CimuDbi18.new if ((@s_result = CimuDbi18.where(:class_id => self.id, :class_name => self.class.name, :language_type => language_type).first).blank?)
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
				    	@s_result.language_type = language_type
				    	@s_result.hash_content = hash_result.to_s
				    	eval("self.#{dbi18_type} = @s_result")
				    end
						new_method = attrs.to_s+"_"+l_type.to_s
						new_method = new_method.to_sym
				    self.send :define_method, new_method do #get_value
				      eval(
			    			"
			      	 	self.#{dbi18_type} = CimuDbi18.where(:class_id => self.id, :class_name => self.class.name, :language_type => language_type).first if self.#{dbi18_type}.blank?;
			      	 	return \"\" if (self.#{dbi18_type}).blank?;
			      	 	return \"\" if (self.#{dbi18_type}.hash_content).blank?;
			      	 	return  (eval self.#{dbi18_type}.hash_content)[\"#{attribute}\"]
			      	 	"
				      	 	)
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
			if !(@s_result = CimuDbi18.where(:class_id => self.id, :class_name => self.class.name)).blank?
				@s_result.each do |result|
					result.delete
				end
			end
			super
		end
			
	end
end
end