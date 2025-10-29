class BrokertoolkitController < ApplicationController
  def new
    # initialize defaults for the form
    result = nil
    calculator_type = nil
    currency = nil
    amount = nil

    render Brokertoolkit.new(
      result: result,
      calculator_type: calculator_type,
      currency: currency,
      amount: amount
    )
  end

  def create
    # store the result of the strong params method call
    permitted_params = brokertoolkit_params

    # extract params needed for calculation
    calculator_type = permitted_params[:calculator_type]
    amount = permitted_params[:amount]
    currency = permitted_params[:currency]

    # perform calculation
    calculator = BrokerToolkitCalculations.new(permitted_params)
    result = calculator.calculate

    # determine which componenet to render for the targeted turbo stream
    case calculator_type
    when "collectfreight"
      result_component = ToolkitCollectFreightResult.new(result: result)
    when "currency", "gallons", "BDFT", "LLBS"
      result_component = ToolkitSimpleResult.new(calculator_type: calculator_type, result: result)
    else
      head :unprocessable_entity and return
    end

    # use render_to_string to get the raw HTML for the turbo stream
    html_string = render_to_string(result_component)

    # generate target ID for the turbo stream replacement
    target_id = "result-#{calculator_type.downcase}"

    respond_to do |format|
      format.turbo_stream do
        # replace only the small result area, avoiding pull page duplication
        render turbo_stream: turbo_stream.replace(target_id, html: html_string)
      end

      format.html do
        # for a standard HTML request (non-Turbo), render the full component
        render Brokertoolkit.new(
          result: result,
          calculator_type: calculator_type,
          currency: currency,
          amount: amount
        )
      end
    end
  end

  private

  def brokertoolkit_params
    # permits all expected parameters from the forms
    params.permit(:calculator_type, :amount, :currency, :authenticity_token)
  end
end
