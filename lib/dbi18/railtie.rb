require 'rails'
require 'dbi18'

module Dbi18
  class Railtie < Rails::Railtie
    initializer 'db_i18.initialize' do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :include, Erbac::ActiveRecordSupport
      end
    end
  end
end
