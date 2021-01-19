require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/shifts'
require './lib/key'
require './lib/offset'
require 'mocha/minitest'

class ShiftsTest < Minitest::Test
  def test_it_exists_and_has_attributes
    key = Key.new
    offset = Offset.new
    key.create_with_key('02715')
    offset.create_with_assigned_date('040895')
    shifts = Shifts.new(key, offset)
    assert_instance_of Shifts, shifts
    assert_instance_of Key, shifts.shift_key
    assert_instance_of Offset, shifts.shift_offset
    assert_equal ({:A=>3, :B=>27, :C=>73, :D=>20}), shifts.shifts
    assert_equal ({:A=>3, :B=>0, :C=>19, :D=>20}), shifts.simple_shifts
  end

  def test_it_can_generate_shifts_with_inputs
    key = Key.new
    offset = Offset.new
    key.create_with_key('02715')
    offset.create_with_assigned_date('040895')
    shifts = Shifts.new(key, offset)
    shifts.shifts_with_inputs
    assert_equal ({A: 3, B: 27, C: 73, D: 20}), shifts.shifts
  end

  def test_it_can_calculate_simple_shifts
    key = Key.new
    offset = Offset.new
    key.create_with_key('02715')
    offset.create_with_assigned_date('040895')
    shifts = Shifts.new(key, offset)
    shifts.shifts_with_inputs
    shifts.calculate_simple_shifts
    assert_equal ({A: 3, B: 0, C: 19, D: 20}), shifts.simple_shifts
  end

  def test_it_can_generate_shifts_with_todays_date
    key = Key.new
    offset = Offset.new
    key.create_with_key('02715')
    offset.create_with_assigned_date('000000')
    shifts = Shifts.new(key, offset)
    shifts.shifts_with_inputs
    assert_equal ({:A=>6, :B=>33, :C=>75, :D=>16}), shifts.shifts
  end

  def test_it_can_generate_shifts_with_random_key
    key = Key.new
    offset = Offset.new
    offset.create_with_assigned_date('040895')
    key.create_with_key('0000')
    shifts = Shifts.new(key, offset)
    shifts.shifts_with_inputs
    assert_equal 5, shifts.shift_key.key.length
  end

end
