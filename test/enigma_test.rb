require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def test_it_exists_and_has_attributes
    enigma = Enigma.new
    assert_instance_of Enigma, enigma
    assert_equal "", enigma.message
    assert_equal ({}), enigma.shifts
    assert_equal (["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]), enigma.characters
  end

  def test_it_can_encypt_message
    enigma = Enigma.new
    assert_equal ({encryption: "keder ohulw", key: "02715", date: "040895"}), enigma.encrypt("hello world", "02715", "040895")

  end

  def test_it_can_get_shifts
    enigma = Enigma.new
    assert_equal ({:A=>3, :B=>27, :C=>73, :D=>20}), enigma.get_shifts("02715", "040895")
  end



end
