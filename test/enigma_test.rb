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
    enigma.encrypt("hello world", "02715", "040895")
    assert_equal ({:A=>3, :B=>27, :C=>73, :D=>20}), enigma.shifts
  end
  def test_it_can_shift_message
    enigma = Enigma.new
    enigma.encrypt("hello world", "02715", "040895")
    enigma.expects(:encrypted_array).returns( ["k", "e", "d", "e", "r", " ", "o", "h", "u", "l", "w"])
    assert_equal  ["k", "e", "d", "e", "r", " ", "o", "h", "u", "l", "w"], enigma.encrypted_array
  end

  def test_it_can_unshift_message
    enigma = Enigma.new
    enigma.encrypt("hello world", "02715", "040895")
    enigma.expects(:decrypted_array).returns( ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d"])
    assert_equal ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d"], enigma.decrypted_array
  end

  def test_it_can_shift_letter
    enigma = Enigma.new
    enigma.encrypt("", "02715", "040895")
    enigma.shift_letter('h', :A)
    assert_equal "k", enigma.encrypted_array.first
    enigma.shift_letter(' ', :B)
    assert_equal ['k', ' '], enigma.encrypted_array
  end

  def test_it_can_unshift_letter
    enigma = Enigma.new
    enigma.encrypt("", "02715", "040895")
    enigma.unshift_letter('k', :A)
    assert_equal ["h"], enigma.decrypted_array
    enigma.unshift_letter(' ', :B)
    assert_equal ['h', ' '], enigma.decrypted_array
  end

  def test_shift_helper
    enigma = Enigma.new
    enigma.encrypt("", "02715", "040895")
    assert_equal ({:A=>0, :B=>1, :C=>2, :D=>3}), enigma.shift_helper("h")
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
    encrypted = enigma.encrypt("hello world", "21008")
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
end
