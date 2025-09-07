class SolarbenefitsController < ApplicationController
  def index
    render html: SolarBenefits.new.to_html.html_safe
  end
end
