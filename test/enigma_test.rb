require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'
require 'mocha/minitest'

class EnigmaTest < Minitest::Test
  def test_it_exists_and_has_attributes
    enigma = Enigma.new
    assert_instance_of Enigma, enigma
    assert_equal [], enigma.decrypted_array
    assert_equal [], enigma.encrypted_array
    assert_equal ({}), enigma.shifts
    assert_equal (["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]), enigma.characters
  end

  def test_it_can_encrypt
    enigma = Enigma.new
    assert_equal ({encryption: "keder ohulw", key: "02715", date: "040895"}), enigma.encrypt("hello world", "02715", "040895")
  end

  def test_it_can_get_shifts
    enigma = Enigma.new
    assert_equal ({:A=>3, :B=>27, :C=>73, :D=>20}), enigma.get_shifts("02715", "040895")
  end
  def test_it_can_shift_message
    enigma = Enigma.new
    enigma.get_shifts("02715", "040895")
    enigma.shift_message
    enigma.expects(:encrypted_array).returns( ["k", "e", "d", "e", "r", " ", "o", "h", "u", "l", "w"])
    assert_equal  ["k", "e", "d", "e", "r", " ", "o", "h", "u", "l", "w"], enigma.encrypted_array
  end

  def test_it_can_unshift_message
    enigma = Enigma.new
    enigma.get_shifts("02715", "040895")
    enigma.unshift_message
    enigma.expects(:decrypted_array).returns( ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d"])
    assert_equal ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d"], enigma.decrypted_array
  end

  def test_it_can_shift_letter
    enigma = Enigma.new
    enigma.get_shifts("02715", "040895")
    enigma.shift_letter('h', :A)
    assert_equal ["k"], enigma.encrypted_array
    enigma.shift_letter(' ', :B)
    assert_equal ['k', ' '], enigma.encrypted_array
  end

  def test_it_can_unshift_letter
    enigma = Enigma.new
    enigma.get_shifts("02715", "040895")
    enigma.unshift_letter('k', :A)
    assert_equal ["h"], enigma.decrypted_array
    enigma.unshift_letter(' ', :B)
    assert_equal ['h', ' '], enigma.decrypted_array
  end

  def test_shift_helper
    enigma = Enigma.new
    enigma.get_shifts("02715", "040895")
    assert_equal ({:A=>0, :B=>1, :C=>2, :D=>3}), enigma.shift_helper("H")
  end

  def test_it_can_decrypt
    enigma = Enigma.new
    assert_equal ({decryption: "hello world", key: "02715", date: "040895"}), enigma.decrypt("keder ohulw", "02715", "040895")
  end

end
