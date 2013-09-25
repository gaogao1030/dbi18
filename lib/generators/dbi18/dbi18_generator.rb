require 'rails/generators/active_record'
require 'active_support/core_ext'
require 'rails/generators/migration'

module Dbi18
  module Generators
    class Dbi18Generator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
            argument :dbi18_class, type: :string, banner: "dbi18", desc: "dbi18", default: "dbi18"
            class_option :orm, :type => :string, :default => "active_record"
      def show
        p "#{dbi18_class}"
      end


      hook_for :orm
      namespace :dbi18

      desc "rails g dbi18 [parameters]"

    end
  end
end
