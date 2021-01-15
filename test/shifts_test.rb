require 'minitest/autorun'
require 'minitest/pride'
require './lib/shifts'
require 'mocha/minitest'

class ShiftsTest < Minitest::Test
  def test_it_exists_and_has_attributes
    shifts = Shifts.new
    assert_instance_of Shifts, shifts
    assert_equal ({A: 0, B: 0, C: 0, D: 0}), shifts.shifts
  end

  def test_it_can_generate_shifts_with_inputs
    shifts = Shifts.new
    shifts.shifts_with_inputs("02715", "040895")
    assert_equal ({A: 3, B: 27, C: 73, D: 20}), shifts.shifts
  end

  def test_it_can_generate_random_shifts
    shifts = Shifts.new
    shifts.random_shifts
    assert_equal 4, shifts.shifts.length
  end

end
