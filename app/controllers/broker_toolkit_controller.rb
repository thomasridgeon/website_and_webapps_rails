class BrokerToolkitController < ApplicationController
  def index
    render html: BrokerToolkit.new(controller: self, result: nil).to_html.html_safe
  end

  def create
    calculator = BrokerToolkitCalculations.new(params)
    @result = calculator.calculate
    render html: BrokerToolkit.new(controller: self, result: @result).to_html.html_safe
  end
end
