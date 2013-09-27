require 'active_record'

RSpec::Matchers::OperatorMatcher.register(ActiveRecord::Relation, '=~', RSpec::Matchers::BuiltIn::MatchArray)
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Base.send :include, Dbi18::ActiveRecordSupport

load File.dirname(__FILE__) + '/../schema.rb'

# ActiveRecord models
class Sub1 < ActiveRecord::Base
	# attr_accessible :name
	db_i18n(:name,:des)
end

class Sub2 < ActiveRecord::Base
	# attr_accessible :name, :auth_type, :description, :bizrule, :data
end

