class BrokertoolkitController < ApplicationController
  def new
    # render html: Brokertoolkit.new(controller: self, result: nil, calculator_type: nil).to_html.html_safe
    # switching to rendering a phlex component instead of an Erector widget:

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
    # render html: Brokertoolkit.new(controller: self, result: @result, calculator_type: params[:calculator_type]).to_html.html_safe
    # switching to rendering a phlex componenet instead of an Erector Widget:

    # store the result of the strong params method call
    permitted_params = brokertoolkit_params

    # extract params needed for calculation
    calculator_type = permitted_params[:calculator_type]
    amount = permitted_params[:amount]
    currency = permitted_params[:currency]

    # perform calculation
    calculator = BrokerToolkitCalculations.new(permitted_params)
    result = calculator.calculate

    # render the same component, passing the results and selected values
    respond_to do |format|
      format.html do
        render Brokertoolkit.new(
          result: result,
          calculator_type: calculator_type,
          currency: currency,
          amount: amount
        )
     end
     format.turbo_stream do
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
