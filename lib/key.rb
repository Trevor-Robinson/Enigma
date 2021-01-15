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

  def create_randomize
    @key = sprintf '%05i', rand(99999)
    assign_shift_keys
  end

  def create_with_assigned_key(key)
    @key = key
    assign_shift_keys
  end

  def assign_shift_keys
    @a_key = [@key[0], @key[1]].join.to_i
    @b_key = [@key[1], @key[2]].join.to_i
    @c_key = [@key[2], @key[3]].join.to_i
    @d_key = [@key[3], @key[4]].join.to_i
  end
end
