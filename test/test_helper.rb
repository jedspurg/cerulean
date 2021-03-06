require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'cerulean'

require 'minitest/autorun'
require 'minitest/pride'

# Compatability for older MiniTest versions (ie Rails 4.0 uses MiniTest 4.7)
MiniTest::Test = MiniTest::Unit::TestCase unless defined?(MiniTest::Test)

require 'active_record'
require 'pg'

ActiveRecord::Base.establish_connection(adapter: 'postgresql', database: 'cerulean_test')
