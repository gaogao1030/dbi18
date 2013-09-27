Dbi18.configure do |config|
	# For the time being, maybe in the long term, it only support ActiveRecord...
	# models and database tables
	# config.language_type = [:en,:zh]
	config.model = <%= class_name %>
end