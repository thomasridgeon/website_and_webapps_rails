class BrokerToolkitCalculations
  #---currency converter----

  CONVERSION_RATES = {
    "USD" => 2.0,
    "GBP" => 2.6531,
    "EUR" => 2.2675,
    "XCD" => 0.74
  }

  COLLECT_FREIGHT_RATE = 2.02768
  FX_CHARGE_RATE = 0.02

  def initialize(params)
    @calculator_type = params[:calculator_type]
    @params = params
  end

  def calculate
    case @calculator_type
    when "currency"
      currency_conversion(@params[:currency], @params[:amount])
    when "collectfreight"
      collectfreight_calculation(@params[:amount])
    end
  end

  private

  def currency_conversion(currency, amount)
    currency = currency
    rate = CONVERSION_RATES[currency]

    amount = amount.to_f
    conversion = rate * amount
    "BBD $#{conversion.round(2)}"
  end

  def collectfreight_calculation(amount)
    amount = amount.to_f
    bbd_collect = (amount * COLLECT_FREIGHT_RATE).round(2)
    fx_charge = (bbd_collect * 0.02).round(2)
    {
      bbd_collect: "BBD $#{bbd_collect}",
      fx_charge: "BBD $#{fx_charge}"
    }
  end
end
