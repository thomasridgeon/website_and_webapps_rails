class AboutmeController < ApplicationController
  def index
    render html: AboutMe.new.to_html.html_safe
  end
end
