class TdeeCalculatorModel
  attr_reader :weight, :height, :age, :sex, :activity_level
  # attr_reader is a shortcut for creating getter methods- methods that allow you to read the value of instance variables from outside the class.
  # This makes these instance varibales above readable from outside the class. So this would make me able to do things like tdee.weight or tdee.age

  def initialize(weight:, height:, age:, sex:, activity_level:)
    @weight = weight
    @height = height
    @age = age
    @sex = sex
    @activity_level = activity_level
    # the parameters weight, height, age, sex and activity_level are temporary local variables available only inside the initialize method. By assigning them to instance variables (with an @), I am saying "store these values inside the object, so they are abailable to all other methods in the object"
  end

  def tdee # using the Mifflin-St Jeor equation
    bmr = if sex == "male"
      88.36 + (13.4 * weight) + (4.8 * height) - (5.7 * age)
    else
      447.6 + (9.2 * weight) + (3.1 * height) - (4.3 * age)
    end

    multiplier = {
      "sedentary" => 1.2,
      "light" => 1.375,
      "moderate" => 1.55,
      "very_active" => 1.725,
      "extra_active" => 1.9
    } [activity_level]

    (bmr * multiplier).round
  end
end
