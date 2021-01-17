require './lib/shifts'
require './lib/key'
require './lib/offset'
require 'pry'

class Enigma
  attr_reader :decrypted_array,
              :encrypted_array,
              :shifts,
              :characters
  def initialize
    @decrypted_array = []
    @encrypted_array = []
    @shifts = {}
    @characters = ("a".."z").to_a << " "
    @shift_counters = {A: 0, B: 1, C: 2, D: 3}
  end

  def encrypt(message, key = "00000", date = "000000" )
    @decrypted_array = message.split('')
    get_shifts(key, date)
    shift_message
    encrypted_return = {encryption: @encrypted_array.join, key: key, date: date}
  end

  def shift_message
    @decrypted_array.each do |letter|
        shift_helper(letter)
    end
  end

  def shift_helper(letter)
    @shift_counters.each do |shift, counter|
      if @decrypted_array.index(letter) == counter
        @decrypted_array[counter] = ''
        @shift_counters[shift] += 4
        shift_letter(letter, shift)
        break
      end
    end
  end

  def shift_letter(letter, shift)
    position = @characters.index(letter) + @shifts[shift]
    if position <= 27
      @encrypted_array << @characters[position]
    elsif position <= 54
      @encrypted_array << @characters[position - 27]
    elsif position <= 81
      @encrypted_array << @characters[position - (27*2)]
    elsif position <= 108
      @encrypted_array << @characters[position - (27*3)]
    elsif position > 108
      @encrypted_array << @characters[position - (27*4)]
    end
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
