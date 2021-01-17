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

  def decrypt(ciphertext, key = "00000", date = "000000")
    @encrypted_array = ciphertext.split('')
    get_shifts(key, date)
    unshift_message
    decrypted_return = {decryption: @decrypted_array.join, key: key, date: date}
  end

  def shift_message
    @decrypted_array.each do |letter|
        shift_helper(letter)
    end
  end

  def unshift_message
    @encrypted_array.each do |letter|
        unshift_helper(letter)
    end
  end

  def unshift_helper(letter)
    @shift_counters.each do |shift, counter|
      if @encrypted_array.index(letter) == counter
        @encrypted_array[counter] = ''
        @shift_counters[shift] += 4
        unshift_letter(letter, shift)
        break
      end
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
    @encrypted_array << @characters[position] if position < 27
    @encrypted_array << @characters[position - 27] if position.between?(28, 54)
    @encrypted_array << @characters[position - (27*2)] if position.between?(55, 81)
    @encrypted_array << @characters[position - (27*3)] if position.between?(82, 108)
    @encrypted_array << @characters[position - (27*4)] if position > 108

  end

  def unshift_letter(letter, shift)
    position = @characters.index(letter) - @shifts[shift]
    @decrypted_array << @characters[position] if position > -27
    @decrypted_array << @characters[position + 27] if position.between?(-54, -28)
    @decrypted_array << @characters[position + (27*2)] if position.between?(-81, -55)
    @decrypted_array << @characters[position + (27*3)] if position.between?(-108, -82)
    @decrypted_array << @characters[position + (27*4)] if position < -108
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
