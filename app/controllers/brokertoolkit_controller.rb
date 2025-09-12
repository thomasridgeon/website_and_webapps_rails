class BrokertoolkitController < ApplicationController
  def new
    render html: Brokertoolkit.new(controller: self, result: nil).to_html.html_safe
  end

  def create
    calculator = BrokerToolkitCalculations.new(params)
    @result = calculator.calculate
    render html: Brokertoolkit.new(controller: self, result: @result).to_html.html_safe
  end
end
