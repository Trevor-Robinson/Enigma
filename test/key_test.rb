require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/key'
require 'mocha/minitest'

class KeyTest < Minitest::Test
  def test_it_exists_and_has_attributes
    key = Key.new
    assert_instance_of Key, key
    assert_equal '00000', key.key
    assert_equal 0, key.a_key
    assert_equal 0, key.b_key
    assert_equal 0, key.c_key
    assert_equal 0, key.d_key
  end

  def test_it_can_generate_random_key
    key = Key.new
    key.expects(:random_key).returns('23574')
    assert_equal '23574', key.random_key
  end

  def test_random_key_is_always_5_digits
    key = Key.new
    100.times do |test|
      assert_equal 5, key.random_key.length
    end
  end

  def test_it_can_create_with_key
    key = Key.new
    key.create_with_key('03574')
    assert_equal '03574', key.key
    key.create_with_key('0357454')
    assert_equal true, key.key != '0357454'
  end


  def test_it_can_generate_shift_keys
    key = Key.new
    key.create_with_key('03574')
    key.assign_shift_keys
    assert_equal 3, key.a_key
    assert_equal 35, key.b_key
    assert_equal 57, key.c_key
    assert_equal 74, key.d_key
  end

  def test_it_can_check_valid_key
    key = Key.new
    assert_equal true, key.check_valid_key('03574')
    assert_equal false, key.check_valid_key('00000')
    assert_equal false, key.check_valid_key('3456')
    assert_equal false, key.check_valid_key('543672')
    assert_equal false, key.check_valid_key(34254)
  end
end
