require 'dbi18/railtie' if defined?(Rails)
require 'dbi18/active_record_support'
require 'erbac/configure'
require "dbi18/version"

module Dbi18
  extend Configure
end
