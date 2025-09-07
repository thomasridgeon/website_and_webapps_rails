class PortchargesController < ApplicationController
  def new
    render html: PortCharges.new.to_html.html_safe
  end

  def create
    calculator = PortchargesCalculation.new(params) # my service model logic
    @result = calculator.calculate
    render html: PortCharges.new(@result).to_html.html_safe
  end
end
