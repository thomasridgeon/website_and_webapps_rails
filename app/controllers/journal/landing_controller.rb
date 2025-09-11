class Journal::LandingController < ApplicationController
  def index
    render html: Journal::Landing.new(controller: self).to_html.html_safe
  end
end
