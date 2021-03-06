# -*- encoding : utf-8 -*-
require 'active_record'
RSpec::Matchers::OperatorMatcher.register(ActiveRecord::Relation, '=~', RSpec::Matchers::BuiltIn::MatchArray)
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Base.send :include, Dbi18::ActiveRecordSupport
load File.dirname(__FILE__) + '/../schema.rb'

# ActiveRecord models

class Cimu < ActiveRecord::Base
		Dbi18.model = Cimu
		Dbi18.locale = [:en,:zh,:jp]
		attr_accessible :class_id, :class_name, :hash_content, :locale
end

class Sub1 < ActiveRecord::Base

	# attr_accessible :name
	db_i18n(:name,:des)
end

class Sub2 < ActiveRecord::Base
	# attr_accessible :name
	# attr_accessible :name, :auth_type, :description, :bizrule, :data
end

class Sub3 < ActiveRecord::Base
	db_i18n(:name)
	validates :name_jp, :presence => true
end

