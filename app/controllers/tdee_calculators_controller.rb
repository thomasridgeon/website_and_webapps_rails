class TdeeCalculatorsController < ApplicationController
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
    # strong params
    # using strong params is best practice with Ruby on Rails. This is for security and clarity. With regards to security, it prevents "mass-assignment" attacks by explicitly permitting only the params need for the app. Also, for the sake of clarity, using strong params makes it clear which inputs the controller uses.
    permitted_params = tdee_calculator_params

    weight = permitted_params[:weight].to_f
    height = permitted_params[:height].to_f
    age = permitted_params[:age].to_i
    sex = permitted_params[:sex]
    activity_level = permitted_params[:activity_level]

    # perform calculation
    calculator = TdeeCalculatorModel.new(
      weight: weight,
      height: height,
      age: age,
      sex: sex,
      activity_level: activity_level
    )

    result = calculator.tdee

    # instantiate the result component for the Turbo response
    result_component = TdeeResult.new(tdee: result)

    # use Rails' built-in render_to_string method to render the result component into an HTML string for targeted placement
    html_string = render_to_string(result_component)

    # respond to Turbo Streams
    respond_to do |format|
      format.turbo_stream do
        # Use raw HTML string of the TdeeResult component
        render turbo_stream: turbo_stream.replace("tdee-result", html: html_string)
      end

      format.html do
        # for a standard HTML request (non-Turbo), render the full component
        render TdeeCalculator.new(
          tdee: result,
          height: height,
          age: age,
          sex: sex,
          activity_level: activity_level
        )
      end
    end
  end

  private
  def tdee_calculator_params
    params.permit(:weight, :height, :age, :sex, :activity_level)
  end
end
