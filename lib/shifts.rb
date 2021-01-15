require './lib/key'
require './lib/offset'
require 'pry'

class Shifts
  attr_reader :shifts
  def initialize
    @shift_key = Key.new
    @shift_offset = Offset.new
    @shifts = {A: 0, B: 0, C: 0, D: 0}
  end

  def shifts_with_inputs(key, date)
    @shift_key.create_with_assigned_key(key)
    @shift_offset.create_with_assigned_date(date)
    @shifts[:A] = @shift_key.a_key + @shift_offset.a_offset
    @shifts[:B] = @shift_key.b_key + @shift_offset.b_offset
    @shifts[:C] = @shift_key.c_key + @shift_offset.c_offset
    @shifts[:D] = @shift_key.d_key + @shift_offset.d_offset
  end

  def random_shifts
    @shift_key.create_randomize
    @shift_offset.create_with_new_date
    @shifts[:A] = @shift_key.a_key + @shift_offset.a_offset
    @shifts[:B] = @shift_key.b_key + @shift_offset.b_offset
    @shifts[:C] = @shift_key.c_key + @shift_offset.c_offset
    @shifts[:D] = @shift_key.d_key + @shift_offset.d_offset
  end


end
