$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'cerulean'

require 'minitest/autorun'
require 'minitest/pride'

# Compatability for older MiniTest versions (ie Rails 4.0 uses MiniTest 4.7)
MiniTest::Test = MiniTest::Unit::TestCase unless defined?(MiniTest::Test)

