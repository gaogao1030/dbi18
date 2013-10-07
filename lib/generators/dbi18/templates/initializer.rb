# -*- encoding : utf-8 -*-
Dbi18.configure do |config|
	# For the time being, maybe in the long term, it only support ActiveRecord...
	# models and database tables
	# config.locale = [:en,:zh]
	config.model = <%= class_name %>
end
