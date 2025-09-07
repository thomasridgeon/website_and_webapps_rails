class Journal::LandingController < ApplicationController
  def index
    render html: JournalLandingPage.new.to_html.html_safe
  end
end
