require './lib/shifts'
require './lib/key'
require './lib/offset'
require 'pry'

class Enigma
  attr_reader :message,
              :shifts,
              :characters
  def initialize
    @message = ''
    @shifts = {}
    @characters = ("a".."z").to_a << " "
  end

  def encrypt(message, key = "00000", date = "000000" )
    @message = message
    get_shifts(key, date)
    message_array = @message.split('')
    a_counter = 0
    b_counter = 1
    c_counter = 2
    d_counter = 3
    encrypted = []
    message_array.each do |letter|
      if message_array.index(letter) == a_counter
        message_array[a_counter] = 0
          a_counter += 4
        if @characters.index(letter) + @shifts[:A] <= 27
          encrypted << @characters[@characters.index(letter) + @shifts[:A]]
        elsif @characters.index(letter) + @shifts[:A] > 27 && @characters.index(letter) + @shifts[:A] <= 54
          encrypted << @characters[@characters.index(letter) + @shifts[:A]- 27]
        elsif @characters.index(letter) + @shifts[:A] > 54 && @characters.index(letter) + @shifts[:A] <= 81
            encrypted << @characters[@characters.index(letter) + @shifts[:A] - (27*2)]
        elsif @characters.index(letter) + @shifts[:A] > 81 && @characters.index(letter) + @shifts[:A] <= 108
            encrypted << @characters[@characters.index(letter) + @shifts[:A] - (27*3)]
        elsif @characters.index(letter) + @shifts[:A] < 108
            encrypted << @characters[@characters.index(letter) + @shifts[:A] - (27*4)]
        end
      elsif message_array.index(letter) == b_counter
        message_array[b_counter] = 0
          b_counter += 4
        if @characters.index(letter) + @shifts[:B] <= 27
           encrypted << @characters[@characters.index(letter) + @shifts[:B]]
        elsif @characters.index(letter) + @shifts[:B] > 27 && @characters.index(letter) + @shifts[:B] <= 54
           encrypted << @characters[@characters.index(letter) + @shifts[:B]- 27]
        elsif @characters.index(letter) + @shifts[:B] > 54 &&  @characters.index(letter) + @shifts[:B] <= 81
             encrypted << @characters[@characters.index(letter) + @shifts[:B] - (27*2)]
        elsif @characters.index(letter) + @shifts[:B] > 81 && @characters.index(letter) + @shifts[:B] <= 108
            encrypted << @characters[@characters.index(letter) + @shifts[:B] - (27*3)]
        elsif @characters.index(letter) + @shifts[:B] < 108
            encrypted << @characters[@characters.index(letter) + @shifts[:B] - (27*4)]
        end
      elsif message_array.index(letter) == c_counter
        message_array[c_counter] = 0
          c_counter += 4
        if @characters.index(letter) + @shifts[:C] <= 27
           encrypted << @characters[@characters.index(letter) + @shifts[:C]]
        elsif @characters.index(letter) + @shifts[:C] > 27 && @characters.index(letter) + @shifts[:C] <= 54
           encrypted << @characters[@characters.index(letter) + @shifts[:C] - 27]
        elsif @characters.index(letter) + @shifts[:C] > 54 && @characters.index(letter) + @shifts[:C] <= 81
             encrypted << @characters[@characters.index(letter) + @shifts[:C] - (27*2)]
        elsif @characters.index(letter) + @shifts[:C] > 81 && @characters.index(letter) + @shifts[:C] <= 108
             encrypted << @characters[@characters.index(letter) + @shifts[:C] - (27*3)]
        elsif @characters.index(letter) + @shifts[:C] < 108
             encrypted << @characters[@characters.index(letter) + @shifts[:C] - (27*4)]
        end
      elsif message_array.index(letter) == d_counter
        message_array[d_counter] = 0
          d_counter += 4
        if @characters.index(letter) + @shifts[:D] <= 27
           encrypted << @characters[@characters.index(letter) + @shifts[:D]]
        elsif @characters.index(letter) + @shifts[:D] > 27 && @characters.index(letter) + @shifts[:D] <= 54
           encrypted << @characters[@characters.index(letter) + @shifts[:D] - 27]
        elsif @characters.index(letter) + @shifts[:D] > 54 && @characters.index(letter) + @shifts[:D] <= 81
             encrypted << @characters[@characters.index(letter) + @shifts[:D] - (27*2)]
        elsif @characters.index(letter) + @shifts[:D] > 81 && @characters.index(letter) + @shifts[:D] <= 108
             encrypted << @characters[@characters.index(letter) + @shifts[:D] - (27*3)]
        elsif @characters.index(letter) + @shifts[:D] < 108
             encrypted << @characters[@characters.index(letter) + @shifts[:D] - (27*4)]
        end
      end
    end
    encrypted_return = {encryption: encrypted.join, key: key, date: date}
  end

  def get_shifts(key, date)
    shift_key = Key.new
    shift_offset = Offset.new
    shift_key.create_with_assigned_key(key)
    shift_offset.create_with_assigned_date(date)
    shifts = Shifts.new(shift_key, shift_offset)
    shifts.shifts_with_inputs
    @shifts = shifts.shifts
  end
end
