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

  GALLONS_TO_LITRES = 3.785412

  BDFT_TO_CUBICMT = 0.0023622

  LLBS_TO_KGS = 0.4536

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
    when "gallons"
      gallons_conversion(@params[:amount])
    when "BDFT"
      bdft_conversion(@params[:amount])
    when "LLBS"
      llbs_conversion(@params[:amount])
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

  def gallons_conversion(amount)
    amount = amount.to_f
    litres = (amount * GALLONS_TO_LITRES).round(2)
    "Customs litres = #{litres}"
  end

  def bdft_conversion(amount)
    amount = amount.to_f
    cubicmt = (amount * BDFT_TO_CUBICMT).round(2)
    "Cubic metres = #{cubicmt}"
  end

  def llbs_conversion(amount)
    amount = amount.to_f
    kgs = (amount * LLBS_TO_KGS).round(2)
    "Kilograms = #{kgs}"
  end
end
