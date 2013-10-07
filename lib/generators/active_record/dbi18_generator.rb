# -*- encoding : utf-8 -*-
require 'rails/generators/active_record'
require 'active_support/core_ext'

module ActiveRecord
  module Generators
    class Dbi18Generator < ActiveRecord::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      argument :dbi18_class, type: :string, banner: "dbi18", desc: "dbi18", default: "dbi18"

      # def show
      #   p "#{table_name}"
      #   p "#{class_name}"
      #   p "#{name}"
      # end

      def generate_auth_item_model
         invoke "active_record:model", ["#{name}", "class_id", "class_name", "locale", "hash_content",   "--no-migration"], :migration => false
        # Rails::Generators.invoke("active_record:model", ["db_i18", "class_id", "class_name", "property", "hash_content",  "--no-migration"], behavior: behavior)
      end

      def copy_dbi18_migration
         migration_template "migration.rb", "db/migrate/create_" + "#{table_name}".singularize
      end

      protected

      def model_path
         File.join("app", "models", "#{table_name}".singularize + ".rb")
      end
      
    end
  end
end
