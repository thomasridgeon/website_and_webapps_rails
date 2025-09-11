class BrokerToolkit < Erector::Widget
  #----currency converter----------
  form action: broker_toolkit_path, method: "post" do
    # this tells the controller & PORO which calculator to run
    input type: "hidden", name: "calculator_type", value: "currency"

    label "Select Currency:"
    select name: "currency" do
      option "USD"
      option "GBP"
      option "EUR"
      option "XCD"
    end

    br

    label "Amount:"
    input type: "number", step: "0.01", name: "amount"

    br
    input type: "submit", value: "Convert"
  end

  if defined?(@result) && @result.present?
    p @result
  end
end
