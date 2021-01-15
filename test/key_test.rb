require 'minitest/autorun'
require 'minitest/pride'
require './lib/key'

class KeyTest < Minitest::Test
  def test_it_exists_and_has_attributes
    key = Key.new
    assert_instance_of Key, key
    assert_equal 00000, key.random
    assert_equal 00, key.a_key
    assert_equal 00, key.b_key
    assert_equal 00, key.c_key
    assert_equal 00, key.d_key
  end
end
