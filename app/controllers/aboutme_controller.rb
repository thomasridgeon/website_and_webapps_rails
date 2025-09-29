class AboutmeController < ApplicationController
  def index
    render html: Aboutme.new.to_html.html_safe
  end
end
