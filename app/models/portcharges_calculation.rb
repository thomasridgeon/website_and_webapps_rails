class PortchargesCalculation
  RATES = {
    "fas" => {
      "20ST" => 1221.98,
      "40ST" => 2443.96,
      "40HC" => 2661.32,
      "20RH" => 1328.93,
      "40RH" => 2657.85
    },
    "security_fee" => {
      "20ST" => 155.10,
      "40ST" => 310.20,
      "40HC" => 310.20,
      "20RH" => 105.75,
      "40RH" => 211.50
    },
    "hazard" => {
      "20ST" => 118.68,
      "40ST" => 259.09,
      "40HC" => 259.09
    },
    "unstuffing" => {
      "20ST" => 528.75,
      "40ST" => 1075.50,
      "40HC" => 1075.50
    },
    "plugs_daily_rate" => {
      "20RH" => 115.15,
      "40RH" => 230.30
    }
  }

  def initialize(params)
    @params = params
  end

  def calculate
    num_containers = @params[:num_containers].to_i
    container_type = @params[:container_type]
    total_charge = 0.0
    breakdown = {}

    if @params[:fas] == "on"
      rate = RATES["fas"][container_type]
      charge = num_containers * rate
      total_charge += charge if rate
      breakdown["FAS"] = charge if rate
    end

    if @params[:security_fee] == "on"
      rate = RATES["security_fee"][container_type]
      charge = num_containers * rate
      total_charge += charge if rate
      breakdown["Security Fee"] = charge if rate
    end

    if @params[:hazard] == "on"
      rate = RATES["hazard"][container_type]
      charge = num_containers * rate
      total_charge += charge if rate
      breakdown["Hazard"] = charge if rate
    end

    if @params[:unstuffing] == "on"
      rate = RATES["unstuffing"][container_type]
      charge = num_containers * rate
      total_charge += charge if rate
      breakdown["Unstuffing"] = charge if rate
    end

    if @params[:plugs_daily_rate] == "on"
      days = @params[:plugs_days].to_i
      if days > 0
        rate = RATES["plugs_daily_rate"][container_type]
        charge = num_containers * days * rate
        total_charge += charge if rate
        breakdown["Plugs Daily Rate"] = charge if rate
      end
    end

    { total: total_charge, breakdown: breakdown }
  end
end
