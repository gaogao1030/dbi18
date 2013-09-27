require 'rubygems'
require 'rails/all'
require 'dbi18'
require "bundler/setup"

Dbi18.configure

load File.dirname(__FILE__) + "/support/adapters/active_record.rb"
load File.dirname(__FILE__) + '/support/data.rb'
