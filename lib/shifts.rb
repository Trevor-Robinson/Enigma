require 'pry'

class Shifts
  attr_reader :shifts,
              :simple_shifts,
              :shift_key,
              :shift_offset
  def initialize(key, offset)
    @shift_key = key
    @shift_offset = offset
    @shifts = {A: 0, B: 0, C: 0, D: 0}
    @simple_shifts = {A: 0, B: 0, C: 0, D: 0}
    shifts_with_inputs
  end

  def shifts_with_inputs
    @shifts[:A] = @shift_key.a_key + @shift_offset.a_offset
    @shifts[:B] = @shift_key.b_key + @shift_offset.b_offset
    @shifts[:C] = @shift_key.c_key + @shift_offset.c_offset
    @shifts[:D] = @shift_key.d_key + @shift_offset.d_offset
    calculate_simple_shifts
  end

  def calculate_simple_shifts
    @shifts.each do |letter, amount|
      simplified = amount
      until simplified < 27
         simplified -= 27
      end
      @simple_shifts[letter] = simplified
    end
  end
end
