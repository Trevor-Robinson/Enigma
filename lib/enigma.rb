require './lib/shifts'
require './lib/key'
require './lib/offset'
require 'pry'

class Enigma
  attr_reader :input_array,
              :output_array,
              :shifts,
              :characters,
              :key,
              :offset,
              :shift_counters,
              :e_or_d,
              :output_hash
  def initialize
    @key = Key.new
    @offset = Offset.new
    @characters = ('a'..'z').to_a << ' '
    @shift_counters = {A: 0, B: 1, C: 2, D: 3}
  end

  def encrypt(message, key = '00000', date = '000000' )
    @output_array = []
    @input_array = []
    @input_array = cleanse_input(message)
    @e_or_d = 'e'
    set_shifts(key, date)
    shift_message(key, date)
    @output_hash = {encryption: @output_array.join, key: @key.key , date: @offset.date}
  end

  def decrypt(ciphertext, key = '00000', date = '000000')
    @output_array = []
    @input_array = []
    @input_array = ciphertext.split('')
    @e_or_d = 'd'
    set_shifts(key, date)
    shift_message(key, date)
    @output_hash = {decryption: @output_array.join, key: @key.key, date: @offset.date}
  end

  def cleanse_input(input)
     input_array = input.downcase.split('')
     input_array.delete('\n')
    input_array
  end

  def shift_message(key, date)
    @input_array.each do |letter|
      if !@characters.include?(letter)
        @output_array << letter
      else
        @shift_counters.each do |shift, counter|
          if @input_array.index(letter) == counter
            @input_array[counter] = ''
            @shift_counters[shift] += 4
            shift_letter(letter, shift)
            break
          end
        end
      end
    end
  end

  def shift_letter(letter, shift)
    index = get_index(letter, shift)
    @output_array << @characters[index] if index <= 26
    @output_array << @characters[index - 27] if index > 26
  end

  def get_index(letter, shift)
    index = @characters.index(letter) + @shifts[shift] if @e_or_d == 'e'
    index = @characters.index(letter) - @shifts[shift] if @e_or_d == 'd'
    index
  end

  def set_shifts(key, date)
    @key.create_with_key(key)
    @offset.create_with_assigned_date(date)
    @shifts = Shifts.new(@key, @offset).simple_shifts
  end
end
