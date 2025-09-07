class HomeController < ApplicationController
  def index
    render html: Home.new.to_html.html_safe
  end
end
