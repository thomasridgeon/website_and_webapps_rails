class Brokertoolkit < Erector::Widget
   needs :result, :controller

  def content
    html do
      head do
        meta(charset: "UTF-8")
        meta(name: "viewport", content: "width=device-width, initial-scale=1.0")
        # meta(charset: 'UTF-8'): This line generates the <meta charset="UTF-8"> tag. This is crucial for web browsers to correctly display characters from different languages.
        # meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0'): This generates a meta tag that is essential for making the page responsive and look good on mobile devices. It tells the browser to match the page's width to the device's screen width.
        title "Customs Broker Toolkit"

        link(rel: "preconnect", href: "https://fonts.googleapis.com")
        link(rel: "preconnect", href: "https://fonts.gstatic.com", crossorigin: "anonymous")
        link(rel: "stylesheet", href: "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css")
        link(href: "https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap",
             rel: "stylesheet")

        # ---Custom font CSS------------------------
        style do
          rawtext <<-CSS
      html, body {
        font-family: 'Montserrat', sans-serif !important;
      }
          CSS
        end
      end


      # ---body section-----------
      body(class: "bg-slate-100 min-h-screen p-4 sm:p-8") do
        h1(class: "text-2xl sm:text-3xl md:text-4xl lg:text-5xl font-bold text-center text-slate-800 mt-10 mb-10 md:mb-20") do
          text "Customs Broker Toolkit"
        end

          # ===================================
          # ---Card 1: Currency Converter------
          # ===================================

          div(class: "bg-white p-6 sm:p-8 md:p-10 rounded-xl shadow-2xl max-w-lg w-full mx-auto mb-8") do
            h2(class: "text-lg sm:text-xl font-semibold text-center text-slate-800 mb-4") do
              text "Customs Currency Converter"
            end

            form(action: "/brokertoolkit", method: "post") do
              input(type: "hidden", name: "authenticity_token", value: @controller.send(:form_authenticity_token))
              input type: "hidden", name: "calculator_type", value: "currency"

              div(class: "mb-6") do
                label("Select Currency:", for: "currency", class: "block text-sm font-medium text-gray-700 mb-2")
                  select(id: "currency", name: "currency", required: true,
                       class: "w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500") do
                  option("Select a currency...", value: "", disabled: true, selected: true)
                  option "USD"
                  option "GBP"
                  option "EUR"
                  option "XCD"
                end
              end

              div(class: "mb-6") do
                label("Amount:", for: "amount", class: "block text-sm font-medium text-gray-700 mb-2")
                input(type: "number", id: "amount", name: "amount", min: "1", step: "0.01", required: true,
                    class: "w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500")
              end

              div(class: "mb-6") do
                input(type: "submit", value: "Convert", class: "w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-4 rounded-lg shadow-md transition duration-200")
              end
            end

              # Show results if it's for this calculator
              if defined?(@result) && @result.present?
                p(class: "text-xl font-semibold text-center") { text @result }
              end # closes if statement
          end # closes div for card 1
      end # closes body
    end # closes html
  end # closes content method
end # closes class
