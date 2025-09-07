class ProjectsController < ApplicationController
  def index
    render html: Projects.new.to_html.html_safe
  end
end
