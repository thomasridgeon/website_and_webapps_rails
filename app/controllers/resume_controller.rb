class ResumeController < ApplicationController
  def index
    render html: Resume.new.to_html.html_safe
  end
end
