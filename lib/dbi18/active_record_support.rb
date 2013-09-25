module Dbi18
	module ActiveRecordSupport
		def self.included(base)
  		base.extend ClassMethods
  	end

module ClassMethods
	def db_i18n(method, *args)
		include Del
		attr_go = (method.to_s+"_go").to_sym
		after_action = ("after"+"_"+attr_go.to_s).to_sym
			self.class_eval do
					  attr_accessor attr_go
					  after_save after_action
				end
		self.send :define_method, after_action do #after_save_action
				eval("if !self.#{attr_go}.blank?
								self.#{attr_go}.class_id = self.id;
								self.#{attr_go}.save;
							else
								self.#{attr_go} = CimuDbi18.new if (self.#{attr_go} = CimuDbi18.where(:class_id => self.id, :class_name => self.class.name, :property => method.to_s).first).blank?;
								self.#{attr_go}.class_id = self.id;
								self.#{attr_go}.property = method.to_s;
								self.#{attr_go}.class_name = self.class.name
								self.save
							end
							")
	  	end
	  	init_attr_method = ("init_"+method.to_s+"_hash_content").to_sym
	  	self.send :define_method, init_attr_method do #initial obeject.attr_go.hash_content
	  		@count = 0
	  		args[0].each do |language|
	  			@count += 1
	  			if @count == 1
	  				@str = "{"
	  			end
	  			if @count < args[0].length
	  				@str += "\"#{language}\"=>\"\","
	  			else
	  				@str += "\"#{language}\"=>\"\"}"
	  			end
	  		end
	  		return @str
	  	end
		args[0].each do |language|
					new_method = method.to_s+"_"+language.to_s+"="
					new_method = new_method.to_sym
					self.send :define_method, new_method do |args| #set_value
						if eval("self.#{attr_go}.blank?")
				    	@s_result = CimuDbi18.new if ((@s_result = CimuDbi18.where(:class_id => self.id, :class_name => self.class.name, :property => method.to_s).first).blank?)
				    else
				    	eval("@s_result = self.#{attr_go}")
				    end
				    	result = self.send "#{init_attr_method}" if @s_result.hash_content.blank?
				    	result = @s_result.hash_content.to_s if !@s_result.hash_content.blank?
				    	# j_result = JSON.parse result
				    	hash_result = eval result
				    	hash_result["#{language}"] = "#{args}"
				    	@s_result.class_id = self.id#obj.id 
				    	@s_result.class_name = self.class.name #obj.class.name
				    	@s_result.property = method.to_s
				    	@s_result.hash_content = hash_result.to_s
				    	eval("self.#{attr_go} = @s_result")
				    end
						new_method = method.to_s+"_"+language.to_s
						new_method = new_method.to_sym
				      self.send :define_method, new_method do #get_value
				      eval(
			    			"
			      	 	self.#{attr_go} = CimuDbi18.where(:class_id => self.id, :class_name => self.class.name, :property => method.to_s).first if self.#{attr_go}.blank?;
			      	 	return \"\" if (self.#{attr_go}).blank?;
			      	 	return \"\" if (self.#{attr_go}.hash_content).blank?;
			      	 	return  (eval self.#{attr_go}.hash_content)[\"#{language}\"]
			      	 	"
				      	 	)

					    end
		end
			self.send :define_method, method do #get_value_with_i18n.locale
	    	locale = I18n.locale.to_s
	    		self.send  method.to_s+"_"+locale
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