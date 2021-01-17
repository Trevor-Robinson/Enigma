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
    key.create_with_assigned_key("02715")
    offset.create_with_assigned_date("040895")
    shifts = Shifts.new(key, offset)
    assert_instance_of Shifts, shifts
    assert_equal ({A: 0, B: 0, C: 0, D: 0}), shifts.shifts
  end

  def test_it_can_generate_shifts_with_inputs
    key = Key.new
    offset = Offset.new
    key.create_with_assigned_key("02715")
    offset.create_with_assigned_date("040895")
    shifts = Shifts.new(key, offset)
    shifts.shifts_with_inputs
    assert_equal ({A: 3, B: 27, C: 73, D: 20}), shifts.shifts
  end

end
