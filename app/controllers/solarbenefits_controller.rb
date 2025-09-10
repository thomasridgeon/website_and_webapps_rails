class SolarbenefitsController < ApplicationController
  def index
    render html: Solarbenefits.new.to_html.html_safe
  end
end
