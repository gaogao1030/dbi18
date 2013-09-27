require 'rails/generators/active_record'
require 'active_support/core_ext'
require 'rails/generators/migration'

module Dbi18
  module Generators
    class Dbi18Generator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)
      # argument :dbi18_class, type: :string, banner: "dbi18", desc: "dbi18", default: "dbi18"
      namespace :dbi18
      desc "rails g dbi18 [parameters]"


      hook_for :orm


      def copy_initializer_file
        template "initializer.rb", "config/initializers/dbi18.rb"
      end
      
    end
  end
end
