class BrokerToolkitCalculations
  #---currency converter----

  CONVERSION_RATES = {
    "USD" => 2.0,
    "GBP" => 2.6531,
    "EUR" => 2.2675,
    "XCD" => 0.74
  }

  def initialize(params)
    @calculator_type = params[:calculator_type]
    @params = params
  end

  def calculate
    case @calculator_type
    when "currency"
      currency_conversion(@params[:currency], @params[:amount])
    when "collectfreight"
      collectfreight_calculation(@params[:collectfreight], @params[:amount])
    end
  end

  private

  def currency_conversion(currency, amount)
    currency = currency
    rate = CONVERSION_RATES[currency]

    amount = amount.to_f
    conversion = rate * amount
    "#{currency} #{amount} in BBD is #{conversion.round(2)}"
  end
end
