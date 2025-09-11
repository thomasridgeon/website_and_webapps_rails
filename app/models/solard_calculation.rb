class SolardCalculation
  SKIN_MULTIPLIERS = {
    1 => 0.8,
    2 => 1.0,
    3 => 1.25,
    4 => 1.6,
    5 => 2.5,
    6 => 7.5
  }

  attr_reader :uv_index, :age, :skin_type
  # attr_reader declares as readable the instance variables with regard to which the values uv_index, age and skin_type have been assigned to below.
  # this means I can access these instance variables with methods of the same name
  def initialize(uv_index:, age:, skin_type:)
    @uv_index = uv_index
    @age = age
    @skin_type = skin_type
  end

  def age_factor
    if age >= 60 # This is the first condition, which checks if the person is 60 years or older. If true, the code inside this block will run.
      age > 80 ? 0.5 : 0.75 - ((age - 60) * (0.25 / 20.0))
      # This is a ternary operator.
      # age > 80 ? 0.5: It first checks if the age is greater than 80. If it is, the factor is fixed at 0.5, representing a 50% reduction in efficiency.
      # age > 80 ? 0.5 is the true part of the ternary operator. The : separates the true and false results. What comes after the colon is what is calculated for the false side, so if the age is not greater than 80.
      # 0.75: This is the starting efficiency factor at age 60. The model assumes a person's vitamin D efficiency has already decreased to 75% by age 60.
      # (age - 60) This part calculates the number of years past 60. For example, if someone is 70 years old, this part evaluates to (70 - 60) = 10.
      # (0.25 / 20.0): This calculates the annual rate of reduction. The model assumes a total reduction of 0.25 (25%) between the ages of 60 and 80. By dividing this total reduction by the number of years (20), we get the annual rate of 0.0125.
      # ((age - 60) * (0.25 / 20.0)): This multiplies the years past 60 by the annual rate to get the total reduction amount. For a 70-year-old, this would be 10 * 0.0125 = 0.125.
      # 0.75 - 0.125: Finally, the total reduction is subtracted from the starting factor. For a 70-year-old, the final age factor would be 0.75 - 0.125 = 0.625. This means their vitamin D efficiency is at 62.5%.
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
# 10.0 is the base time in minutes. It represents the time a person with a skin type of 2 (SKIN_MULTIPLIERS value of 1.0), under an assumed baseline UV index of 7, would need to get 1000 IU, without any age related reduction.
# 7.0 is used as a baseline to scale the calculation relative to an average UV index
# A higher UV index means the sunlight is stronger and you need less time to get the same amount of vitamin D. The ratio (7.0 / uv_index) will be less than 1, acting as a reduction factor.
# Example: If the UV index is 10, the factor is (7.0 / 10.0) = 0.7. This means the required sun time is reduced to 70% of what it would be at the baseline UV index of 7. The total calculation multiplies all the factors together.
# 10.0 (baseline minutes) * 1.0 (skin type 2) * 1.0 (age <= 30) * 0.7 = 7 minutes
# A lower UV index means the sunlight is weaker, and you need more time to get the same amount of vitamin D. The ratio (7.0 / uv_index) will be greater than 1, acting as an increase factor.
# Example: If the UV index is 3, the factor is (7.0 / 3.0) ≈ 2.33. This means the required sun time is increased to 233% of what it would be at the baseline UV index of 7.
# 10.0 (baseline minutes) * 1.0 (skin type 2) * 1.0 (age <= 30) * 2.33 = 23.3 minutes
