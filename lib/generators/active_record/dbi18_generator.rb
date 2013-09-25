require 'rails/generators/active_record'
require 'active_support/core_ext'

module ActiveRecord
  module Generators
    class Dbi18Generator < ActiveRecord::Generators::Base
      source_root File.expand_path("../templates", __FILE__)


      def generate_auth_item_model
         invoke "active_record:model", ["cimu_dbi18", "class_id", "class_name", "property", "hash_content",  "--no-migration"], :migration => false
        # Rails::Generators.invoke("active_record:model", ["db_i18", "class_id", "class_name", "property", "hash_content",  "--no-migration"], behavior: behavior)
      end

      # def inject_auth_item_model
      #   if behavior == :invoke
      #     inject_into_class model_path("dbi18"), Dbi18 do
      #       attr_accessor :property_map
      #     end
      #   end
      # end

      def copy_erbac_migration
        migration_template "migration.rb", "db/migrate/create_cimu_dbi18"
      end

      protected

      def model_path(filename)
        File.join("app", "models", "#{filename}.rb")
      end
      
    end
  end
end