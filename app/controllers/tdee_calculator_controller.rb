class TdeeCalculatorController < ApplicationController
  def new
    render TdeeCalculator.new(
      tdee: nil,
      weight: nil,
      height: nil,
      age: nil,
      sex: nil,
      activity_level: nil
    )
  end

  def create
    permitted_params = tdee_calculator_params

    weight = permitted[:weight].to_f
    height = permitted[:height].to_f
    age = permitted[:age].to_i
    sex = permitted[:sex]
    activity_level = permitted[:activity_level]

    calculator = TdeeCalculator.new(
      weight: weight,
      height: height,
      age: age,
      sex: sex,
      activity_level: activity_level
    )

    result = calculator.tdee

    render TdeeCalculator.new(
      tdee: result,
      weight: weight,
      height: height,
      age: age,
      sex: sex,
      activity_level: activity_level
    )
  end

  private
  def tdee_calculator_params
    params.permit(:weight, :height, :age, :sex, :activity_level)
  end
end

# using strong params is best practice with Ruby on Rails. This is for security and clarity. With regards to security, it prevents "mass-assignment" attacks by explicitly permitting only the params need for the app. Also, for the sake of clarity, using strong params makes it clear which inputs the controller uses.
