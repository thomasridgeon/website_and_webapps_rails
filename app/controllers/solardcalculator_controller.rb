class SolardcalculatorController < ApplicationController
  OPENUV_API_KEY = ENV["OPENUV_API_KEY"]
  def new
    render html: SolardCalculator.new(controller: self).to_html.html_safe
    @uv_index = fetch_uv_index
  end

  def create
      uv_index = params[:uv_index]&.to_f
    age = params[:age]&.to_i
    skin_type = params[:skin_type]&.to_i

    if uv_index.nil? || age.nil? || skin_type.nil?
      redirect_to new_solardcalculator_path, alert: "Please provide all parameters"
      return
    end

    calculation = SolardCalculation.new(uv_index: uv_index, age: age, skin_type: skin_type)
    @required_sun_time = calculation.required_sun_time
    @uv_index = uv_index
    render html: SolardCalculator.new(@required_sun_time, @uv_index, controller: self).to_html.html_safe
  end

  private

  def fetch_uv_index
    ip = request.remote_ip
    location_response = HTTParty.get("http://ip-api.com/json/#{ip}")
    if location_response.success? && JSON.parse(location_response.body)["status"] == "success"
      data = JSON.parse(location_response.body)
      lat = data["lat"]
      lng = data["lon"]
    else
      # fallback for localhost
      lat = 13.1939
      lng = -59.5432
    end

    response = HTTParty.get(
      "https://api.openuv.io/api/v1/uv?lat=#{lat}&lng=#{lng}",
      headers: { "x-access-token" => OPENUV_API_KEY }
    )
    return nil unless response.success?
    JSON.parse(response.body)["result"]["uv"]
  end
end
