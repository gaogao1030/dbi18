require 'active_record'
RSpec::Matchers::OperatorMatcher.register(ActiveRecord::Relation, '=~', RSpec::Matchers::BuiltIn::MatchArray)
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Base.send :include, Dbi18::ActiveRecordSupport
load File.dirname(__FILE__) + '/../schema.rb'

# ActiveRecord models

class Cimu < ActiveRecord::Base
		Dbi18.model = Cimu
		Dbi18.language_type = [:en,:zh]
		attr_accessible :class_id, :class_name, :hash_content, :language_type
end

class Sub1 < ActiveRecord::Base

	# attr_accessible :name
	db_i18n(:name,:des)
end

class Sub2 < ActiveRecord::Base
	# attr_accessible :name, :auth_type, :description, :bizrule, :data
end

