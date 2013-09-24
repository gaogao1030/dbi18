require 'rails/generators/active_record'
require 'active_support/core_ext'
require 'rails/generators/migration'

module Dbi18
  module Generators
    class Dbi18Generator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      # argument :user_class, type: :string, banner: "User", desc: "User class for the system, maybe User, Account or Admin etc. in  your case."


      hook_for :orm
      # namespace :dbi18

      desc "Generates RBAC(role base access control) models and migration files according to the USER"
      # def show_parameters
      #   puts "user:    " + self.user
      #   puts "auth_item:       " + self.options[:auth_item].inspect
      #   puts "auth_item_child: " + self.options[:auth_item_child].inspect
      #   puts "auth_assignment: " + self.options[:auth_assignment].inspect
      #   puts "options:         " + options.inspect
      # end
    end
  end
end
