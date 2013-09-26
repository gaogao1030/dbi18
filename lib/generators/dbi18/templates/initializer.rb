Dbi18.configure do |config|
	# For the time being, maybe in the long term, it only support ActiveRecord...

	# Uncomment the item to override the default

	# if this is set to true, bizrule should return true restrictly
	# else bizrule will pass if they don't return false
	# NB in ruby 0 != false and 1 != true
	# config.strict_check_mode = true

	# check these roles first
	# config.default_roles = []

	# models and database tables
	# <%= "# " if user_class == Erbac::Configure::USER_CLASS %>config.user_class = <%= %Q("#{user_class}") %>
	config.attrbutes = :name,:des
	config.language_type = [:en,:zh]
end