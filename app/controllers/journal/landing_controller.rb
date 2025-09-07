class Journal::LandingController < ApplicationController
  def index
    render html: Landing.new.to_html.html_safe
  end
end
