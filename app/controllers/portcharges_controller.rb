class PortchargesController < ApplicationController
  def new
    render html: PortCharges.new(controller: self, result: nil).to_html.html_safe
    # By passing controller: self, I'm giving the Erector widget access to the entire controller instance.
    # I need to do this because the widget itself is not a part of the standard Rails request-response cycle and therefore doesn't have direct access to the helper methods provided by the controller.
    # and I need the form_authenticity_token helper for my form submission.
  end

  def create
    calculator = PortchargesCalculation.new(params) # my service model logic
    @result = calculator.calculate
    render html: PortCharges.new(controller: self, result: @result).to_html.html_safe
  end
end
