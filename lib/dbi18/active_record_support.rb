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
		language.each do |l_type|
		locale = l_type.to_s
		dbi18_type = ("dbi18_"+locale).to_sym
		after_action = ("after"+"_"+dbi18_type.to_s).to_sym
			self.class_eval do
					  attr_accessor dbi18_type
					  after_save after_action
				end
		self.send :define_method, after_action do #after_save_action 
			#else 考虑Dbi18.model.new.save的情况
				eval(
							"
							if !self.#{dbi18_type}.blank?
								self.#{dbi18_type}.class_id = self.id;
								self.#{dbi18_type}.save
							else
								self.#{dbi18_type} = (Dbi18.model).new if (self.#{dbi18_type} = (Dbi18.model).where(:class_id => self.id, :class_name => self.class.name, :locale => locale).first).blank?;
								self.#{dbi18_type}.class_id = self.id;
								self.#{dbi18_type}.locale = locale;
								self.#{dbi18_type}.class_name = self.class.name
								self.#{dbi18_type}.save
							end
							"
							)
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
