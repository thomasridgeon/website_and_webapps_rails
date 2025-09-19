class BrokertoolkitController < ApplicationController
  def new
    render html: Brokertoolkit.new(controller: self, result: nil, calculator_type: nil).to_html.html_safe
  end

  def create
    calculator = BrokerToolkitCalculations.new(params)
    @result = calculator.calculate
    calculator_type = params[:calculator_type]
    render html: Brokertoolkit.new(controller: self, result: @result, calculator_type: params[:calculator_type]).to_html.html_safe
  end
end
