require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'
require './lib/shifts'
require './lib/key'
require './lib/offset'
require 'mocha/minitest'

class EnigmaTest < Minitest::Test
  def test_it_exists_and_has_attributes
    enigma = Enigma.new
    assert_instance_of Enigma, enigma
    assert_instance_of Key, enigma.key
    assert_instance_of Offset, enigma.offset
    assert_equal [], enigma.input_array
    assert_equal [], enigma.output_array
    assert_equal ({}), enigma.shifts
    assert_equal (["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]), enigma.characters
    assert_equal ({A: 0, B: 1, C: 2, D: 3}), enigma.shift_counters
    assert_equal '', enigma.e_or_d
  end

  def test_it_can_encrypt
    enigma = Enigma.new
    assert_equal ({encryption: "keder ohulw", key: "02715", date: "040895"}), enigma.encrypt("hello world", "02715", "040895")
  end

  def test_it_can_set_shifts
    enigma = Enigma.new
    enigma.encrypt("hello world", "02715", "040895")
    assert_equal ({:A=>3, :B=>0, :C=>19, :D=>20}), enigma.shifts
  end
  def test_it_can_shift_message
    enigma = Enigma.new
    enigma.encrypt("hello world", "02715", "040895")
    enigma.expects(:output_array).returns( ["k", "e", "d", "e", "r", " ", "o", "h", "u", "l", "w"])
    assert_equal  ["k", "e", "d", "e", "r", " ", "o", "h", "u", "l", "w"], enigma.output_array
  end

  def test_it_can_shift_letter
    enigma = Enigma.new
    enigma.encrypt("", "02715", "040895")
    enigma.shift_letter('w', :C)
    assert_equal "o", enigma.output_array.first
    enigma.shift_letter(' ', :B)
    assert_equal ['o', ' '], enigma.output_array
  end

  def test_it_can_decrypt
    enigma = Enigma.new
    assert_equal ({decryption: "hello world", key: "02715", date: "040895"}), enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_encrypt_without_date_uses_todays_date
    enigma = Enigma.new
    encrypted = enigma.encrypt("hello world", "02715")
    assert_equal Date.today.strftime("%d%m%y"), encrypted[:date]
  end

  def test_it_can_encrypt_without_key_or_date
    enigma = Enigma.new
    encrypted = enigma.encrypt("hello world")
    assert_equal Date.today.strftime("%d%m%y"), encrypted[:date]
    assert_equal 11, encrypted[:encryption].split('').length
    assert_equal 5, encrypted[:key].length
    assert_equal false, encrypted[:key] == "00000"
  end

  def test_it_can_decrypt_with_a_key
    enigma = Enigma.new
    decrypted = enigma.decrypt("vbscbxcfeik", "64571")
    assert_equal Date.today.strftime("%d%m%y"), decrypted[:date]
    assert_equal "hello world", decrypted[:decryption]
  end

  def test_it_can_get_correct_index
    enigma = Enigma.new
    enigma2 = Enigma.new
    enigma.decrypt("keder ohulw", "02715", "040895")
    assert_equal 3, enigma.get_index('w', :C)
  end
end
