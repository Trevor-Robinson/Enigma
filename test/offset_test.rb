require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/offset'
require 'mocha/minitest'

class OffsetTest < Minitest::Test
  def test_it_exists_and_has_attributes
    offset = Offset.new
    assert_instance_of Offset, offset
    assert_equal '000000', offset.date
    assert_equal '0000', offset.offset
    assert_equal 0, offset.a_offset
    assert_equal 0, offset.b_offset
    assert_equal 0, offset.c_offset
    assert_equal 0, offset.d_offset
  end

  def test_it_can_create_with_new_date
    offset = Offset.new
    assert_equal 6, offset.today_date.length
    assert_instance_of String, offset.today_date
  end

  def test_it_can_create_with_assigned_date
    offset = Offset.new
    offset.create_with_assigned_date('000000')
    offset.create_with_assigned_date('030220')
    assert_equal '030220', offset.date
  end

  def test_it_can_check_valid_date
    offset = Offset.new
    assert_equal true, offset.check_valid_date('030220')
  end

  def test_it_can_calculate_offset
    offset = Offset.new
    offset.create_with_assigned_date('040895')
    assert_equal '1025', offset.offset
  end

  def test_it_can_assign_shift_offsets
    offset = Offset.new
    offset.create_with_assigned_date('040895')
    offset.assign_offsets
    assert_equal 1, offset.a_offset
    assert_equal 0, offset.b_offset
    assert_equal 2, offset.c_offset
    assert_equal 5, offset.d_offset

  end
end
