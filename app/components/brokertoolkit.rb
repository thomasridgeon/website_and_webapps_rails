class Brokertoolkit < Phlex::HTML
  include Phlex::Rails::Helpers::Routes

  def initialize(result:, calculator_type:, currency: nil, amount: nil)
    @result = result
    @calculator_type = calculator_type
    @currency = currency
    @amount = amount
  end

  # helper method to render the correct result component based on type
  def render_result_for(type)
    result_data = (type == @calculator_type) ? @result : nil

    case type
    when "collectfreight"
      render ToolkitCollectFreightResult.new(result: result_data)
    when "currency", "gallons", "BDFT", "LLBS"
      render ToolkitSimpleResult.new(calculator_type: type, result: result_data)
    else
      div(id: "result-#{type.downcase}")
    end
  end

  def view_template
    html do
      head do
        meta(charset: "UTF-8")
        meta(name: "viewport", content: "width=device-width, initial-scale=1.0")
        # meta(charset: 'UTF-8'): This line generates the <meta charset="UTF-8"> tag. This is crucial for web browsers to correctly display characters from different languages.
        # meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0'): This generates a meta tag that is essential for making the page responsive and look good on mobile devices. It tells the browser to match the page's width to the device's screen width.
        title { "Customs Broker Toolkit" }

        link(rel: "preconnect", href: "https://fonts.googleapis.com")
        link(rel: "preconnect", href: "https://fonts.gstatic.com", crossorigin: "anonymous")
        link(rel: "stylesheet", href: "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css")
        link(href: "https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap",
             rel: "stylesheet")

        # ---Custom font CSS------------------------
        style do
          raw "html, body { font-family: 'Montserrat', sans-serif !important; }".html_safe
        end
      end


      # ---body section-----------
      body(class: "bg-slate-100 min-h-screen p-4 sm:p-8") do
        render Blog::Components::Navbar.new
        h1(class: "text-2xl sm:text-3xl md:text-4xl lg:text-5xl font-bold text-center text-slate-800 mt-10 mb-10 md:mb-20") do
          "Customs Broker Toolkit"
        end

          # ===================================
          # ---Card 1: Currency Converter------
          # ===================================

          div(class: "bg-white p-6 sm:p-8 md:p-10 rounded-xl shadow-2xl max-w-lg w-full mx-auto mb-8") do
            h2(class: "text-lg sm:text-xl font-semibold text-center text-slate-800 mb-4") do
              "Customs Currency Converter"
            end

            form(action: brokertoolkit_path, method: "post", data: { turbo_stream: true }) do
              input(type: "hidden", name: "authenticity_token", value: view_context.form_authenticity_token)
              input(type: "hidden", name: "calculator_type", value: "currency")

              div(class: "mb-6") do
                label(for: "currency", class: "block text-sm font-medium text-gray-700 mb-2") do
                  "Select Currency:"
                end
                  select(id: "currency", name: "currency", required: true,
                       class: "w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500") do
                  option(value: "", disabled: true, selected: true) { "Select a currency..." }
                  option(value: "USD", selected: @currency == "USD") { "USD" }
                  option(value: "GBP", selected: @currency == "GBP") { "GBP" }
                  option(value: "EUR", selected: @currency == "EUR") { "EUR" }
                  option(value: "XCD", selected: @currency == "XCD") { "XCD" }
                end
              end

              div(class: "mb-6") do
                label(for: "amount", class: "block text-sm font-medium text-gray-700 mb-2") { "Amount:" }
                input(type: "number", id: "amount", name: "amount", min: "1", step: "0.01", required: true,
                      value: (@calculator_type == "currency" ? @amount : nil),
                      class: "w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500")
              end

              div(class: "mb-6") do
                input(type: "submit", value: "Convert", class: "w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-4 rounded-lg shadow-md transition duration-200")
              end

              # render result component
              render_result_for("currency")
            end
          end

          # =============================================
          # --- Card 2: collect freight calculator-------
          # =============================================
          div(class: "bg-white p-6 sm:p-8 md:p-10 rounded-xl shadow-2xl max-w-lg w-full mx-auto mb-8") do
            h2(class: "text-lg sm:text-xl font-semibold text-center text-slate-800 mb-4") do
              "Collect Freight Calculator"
            end

            form(action: brokertoolkit_path, method: "post", data: { turbo_stream: true }) do
              input(type: "hidden", name: "authenticity_token", value: view_context.form_authenticity_token)
              input(type: "hidden", name: "calculator_type", value: "collectfreight")

              div(class: "mb-6") do
                label(for: "amount", class: "block text-sm font-medium text-gray-700 mb-2") { "USD Collect Freight" }
                input(type: "number", id: "amount", name: "amount", min: "1", step: "0.01", required: true,
                      value: (@calculator_type == "collectfreight" ? @amount : nil),
                      class: "w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500")
              end

              div(class: "mb-6") do
                input(type: "submit", value: "Calculate", class: "w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-4 rounded-lg shadow-md transition duration-200")
              end

              # render result componenet
              render_result_for("collectfreight")
            end
          end

          # ========================================
          # ---Card 3: gallons to customs litres----
          # ========================================
          div(class: "bg-white p-6 sm:p-8 md:p-10 rounded-xl shadow-2xl max-w-lg w-full mx-auto mb-8") do
            h2(class: "text-lg sm:text-xl font-semibold text-center text-slate-800 mb-4") do
              "Gallons to Customs Litres"
            end

            form(action: brokertoolkit_path, method: "post", data: { turbo_stream: true }) do
              input(type: "hidden", name: "authenticity_token", value: view_context.form_authenticity_token)
              input(type: "hidden", name: "calculator_type", value: "gallons")

              div(class: "mb-6") do
                label(for: "amount", class: "block text-sm font-medium text-gray-700 mb-2") { "Gallons" }
                input(type: "number", id: "amount", name: "amount", min: "1", step: "0.01", required: true,
                      value: (@calculator_type == "gallons" ? @amount : nil),
                      class: "w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500")
              end

              div(class: "mb-6") do
                input(type: "submit", value: "Convert", class: "w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-4 rounded-lg shadow-md transition duration-200")
              end

              # render result componenet
              render_result_for("gallons")
            end
          end

          # ========================================
          # ---Card 4: ---bdft to cubicmt----------
          # ========================================
          div(class: "bg-white p-6 sm:p-8 md:p-10 rounded-xl shadow-2xl max-w-lg w-full mx-auto mb-8") do
            h2(class: "text-lg sm:text-xl font-semibold text-center text-slate-800 mb-4") do
              "Board Feet to Cubic Metres"
            end

            form(action: brokertoolkit_path, method: "post", data: { turbo_stream: true }) do
              input(type: "hidden", name: "authenticity_token", value: view_context.form_authenticity_token)
              input(type: "hidden", name: "calculator_type", value: "BDFT")

              div(class: "mb-6") do
                label(for: "amount", class: "block text-sm font-medium text-gray-700 mb-2") { "BDFT" }
                input(type: "number", id: "amount", name: "amount", min: "1", step: "0.01", required: true,
                      value: (@calculator_type == "BDFT" ? @amount : nil),
                      class: "w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500")
              end

              div(class: "mb-6") do
                input(type: "submit", value: "Convert", class: "w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-4 rounded-lg shadow-md transition duration-200")
              end

              # render result componenet
              render_result_for("BDFT")
            end
          end

          # ========================================
          # ---Card 5: ---llbs to kgs---------------
          # ========================================
          div(class: "bg-white p-6 sm:p-8 md:p-10 rounded-xl shadow-2xl max-w-lg w-full mx-auto mb-8") do
            h2(class: "text-lg sm:text-xl font-semibold text-center text-slate-800 mb-4") do
              "LLB to KG"
            end

            form(action: brokertoolkit_path, method: "post", data: { turbo_stream: true }) do
              input(type: "hidden", name: "authenticity_token", value: view_context.form_authenticity_token)
              input type: "hidden", name: "calculator_type", value: "LLBS"

              div(class: "mb-6") do
                label(for: "amount", class: "block text-sm font-medium text-gray-700 mb-2") { "LLB" }
                input(type: "number", id: "amount", name: "amount", min: "1", step: "0.01", required: true,
                      value: (@calculator_type == "LLBS" ? @amount : nil),
                      class: "w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500")
              end

              div(class: "mb-6") do
                input(type: "submit", value: "Convert", class: "w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-4 rounded-lg shadow-md transition duration-200")
              end

              # render result component
              render_result_for("LLBS")
            end
          end
      end # closes body
    end # closes html
  end # closes content method
end # closes class
