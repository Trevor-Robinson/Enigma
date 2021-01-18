
class Offset
  attr_reader :date,
              :offset,
              :a_offset,
              :b_offset,
              :c_offset,
              :d_offset

  def initialize
    @date = "000000"
    @offset = "0000"
    @a_offset = 0
    @b_offset = 0
    @c_offset = 0
    @d_offset = 0
  end

  def today_date
    Date.today.strftime("%d%m%y")
  end

  def create_with_assigned_date(date)
    if check_valid_date(date)
      @date = date
    else
      @date = today_date
    end
    @offset = calculate_offset
    assign_offsets
  end

  def check_valid_date(date)
    return false if !date.is_a?(String) || date.length != 6 || date == "000000"
      date_format = "%d%m%y"
      Date.strptime(date, date_format).strftime("%d%m%y") == date
  end

  def calculate_offset
    ((@date.to_i)**2).to_s[-4..-1]
  end

  def assign_offsets
    @a_offset = @offset[0].to_i
    @b_offset = @offset[1].to_i
    @c_offset = @offset[2].to_i
    @d_offset = @offset[3].to_i
  end

end
