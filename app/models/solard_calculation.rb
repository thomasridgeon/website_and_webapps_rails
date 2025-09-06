class SolardCalculation < ApplicationRecord
  SKIN_MULTIPLIERS = {
    1 => 0.8,
    2 => 1.0,
    3 => 1.25,
    4 => 1.6,
    5 => 2.5,
    6 => 7.5
  }

  attr_reader :uv_index, :age, :skin_type

  def initialize(uv_index:, age:, skin_type:)
    @uv_index = uv_index
    @age = age
    @skin_type = skin_type
  end
  def age_factor
    if age >= 60
      age > 80 ? 0.5 : 0.75 - ((age - 60) * (0.25 / 20.0))
    elsif age > 30
      1.0 - ((age - 30) * (0.25 / 30.0))
    else
      1.0
    end
  end

  def required_sun_time
    return nil if uv_index.nil? || uv_index <= 0
    10.0 * SKIN_MULTIPLIERS[skin_type] * age_factor * (7.0 / uv_index)
  end
end
