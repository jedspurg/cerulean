require 'test_helper'

class CeruleanTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Cerulean::VERSION
  end
end
