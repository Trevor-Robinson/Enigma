require 'minitest/autorun'
require 'minitest/pride'
require './lib/key'
require 'mocha/minitest'

class KeyTest < Minitest::Test
  def test_it_exists_and_has_attributes
    key = Key.new
    assert_instance_of Key, key
    assert_equal "00000", key.key
    assert_equal 00, key.a_key
    assert_equal 00, key.b_key
    assert_equal 00, key.c_key
    assert_equal 00, key.d_key
  end

  def test_it_can_generate_random_number
    key = Key.new
    key.randomize
    key.stubs(:key).returns('23574')
    assert_equal '23574', key.key
  end

  def test_random_number_is_always_5_digits
    key = Key.new
    100.times do |test|
      key.randomize
      assert_equal 5, key.key.length
    end
  end

  def test_it_can_take_in_a_set_key
    key = Key.new
    key.assign_key('23574')
    assert_equal '23574', key.key
  end

  def test_it_can_generate_subkeys
    key = Key.new
    key.assign_key('23574')
    key.assign_subkeys
    assert_equal 23, key.a_key
    assert_equal 35, key.b_key
    assert_equal 57, key.c_key
    assert_equal 74, key.d_key
  end
end
