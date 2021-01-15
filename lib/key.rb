class Key
  attr_reader :key,
              :a_key,
              :b_key,
              :c_key,
              :d_key

  def initialize
    @key = "00000"
    @a_key = 00
    @b_key = 00
    @c_key = 00
    @d_key = 00
  end

  def randomize
    @key = sprintf '%05i', rand(99999)
  end

  def assign_key(key)
    @key = key
  end

  def assign_subkeys
    key_array = @key.split('')
    @a_key = [key_array[0], key_array[1]].join.to_i
    @b_key = [key_array[1], key_array[2]].join.to_i
    @c_key = [key_array[2], key_array[3]].join.to_i
    @d_key = [key_array[3], key_array[4]].join.to_i
  end
end
