require 'test_helper'

class Cerulean::ValueParserTest < Minitest::Test
  def test_true_boolean_values_are_parsed
    ['t', 'true', '1', 1, true].each do |value|
      assert_equal true, Cerulean::ValueParser.parse(value, :boolean), "#{value.inspect} did not parse to true"
    end
  end

  def test_false_boolean_values_are_parsed
    ['f', 'false', '0', 0, false, 'a string', 7, ''].each do |value|
      assert_equal false, Cerulean::ValueParser.parse(value, :boolean), "#{value.inspect} did not parse to false"
    end
  end

  def test_nil_for_value_returns_nil
    assert_equal nil, Cerulean::ValueParser.parse(nil, :boolean)
    assert_equal nil, Cerulean::ValueParser.parse(nil, :string)
    assert_equal nil, Cerulean::ValueParser.parse(nil, :integer)
  end

  def test_empty_string_for_integer_returns_nil
    assert_equal nil, Cerulean::ValueParser.parse('', :integer)
  end

  def test_integer_is_parsed_to_a_string
    assert_equal '4', Cerulean::ValueParser.parse(4, :string)
  end
end
