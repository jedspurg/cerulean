require 'test_helper'

class Cerulean::ChainTest < Minitest::Test
  def test_invoke_processes_for_blank_checks
    assert_equal true, Cerulean::Chain.invoke?('', :blank)
    assert_equal true, Cerulean::Chain.invoke?(nil, :blank)
    assert_equal true, Cerulean::Chain.invoke?(false, :blank)
    assert_equal false, Cerulean::Chain.invoke?('x', :blank)
    assert_equal false, Cerulean::Chain.invoke?(2, :blank)
    assert_equal false, Cerulean::Chain.invoke?(true, :blank)
  end

  def test_invoke_processes_for_nil_checks
    assert_equal true, Cerulean::Chain.invoke?(nil, :nil)
    assert_equal false, Cerulean::Chain.invoke?('', :nil)
    assert_equal false, Cerulean::Chain.invoke?(false, :nil)
    assert_equal false, Cerulean::Chain.invoke?('x', :nil)
    assert_equal false, Cerulean::Chain.invoke?(2, :nil)
    assert_equal false, Cerulean::Chain.invoke?(true, :nil)
  end

  def test_invoke_processes_for_false_checks
    assert_equal true, Cerulean::Chain.invoke?(false, :false)
    assert_equal false, Cerulean::Chain.invoke?(nil, :false)
    assert_equal false, Cerulean::Chain.invoke?('', :false)
    assert_equal false, Cerulean::Chain.invoke?('x', :false)
    assert_equal false, Cerulean::Chain.invoke?(2, :false)
    assert_equal false, Cerulean::Chain.invoke?(true, :false)
  end
end
