class PortchargesController < ApplicationController
  def new
  end

  def create
    calculator = PortchargesCalculation.new(params)
    @result = calculator.calculate
  end
end
