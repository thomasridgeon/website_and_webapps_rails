#---Port Charges Calculator Widget-----
class PortCharges < Erector::Widget
  needs :result, :controller

  def content
    html do
      head do
        meta(charset: "UTF-8")
        meta(name: "viewport", content: "width=device-width, initial-scale=1.0")
        # meta(charset: 'UTF-8'): This line generates the <meta charset="UTF-8"> tag. This is crucial for web browsers to correctly display characters from different languages.
        # meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0'): This generates a meta tag that is essential for making the page responsive and look good on mobile devices. It tells the browser to match the page's width to the device's screen width.
        title "Port Charges Calculator"

        link(rel: "preconnect", href: "https://fonts.googleapis.com")
        link(rel: "preconnect", href: "https://fonts.gstatic.com", crossorigin: "anonymous")
        link(rel: "stylesheet", href: "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css")
        link(href: "https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap",
             rel: "stylesheet")

        # Custom font CSS
        style do
          rawtext <<-CSS
      html, body {
        font-family: 'Montserrat', sans-serif !important;
      }
          CSS
        end
      end

      body(class: "font-sans bg-slate-100 flex items-center justify-center min-h-screen p-5") do
        div(class: "container bg-white p-10 rounded-xl shadow-2xl max-w-lg w-full") do
          h1(class: "text-3xl font-bold text-center text-slate-800 mb-8") do
            text "Port Charges Calculator"
          end

          form(action: "/portcharges", method: "post") do
            input(type: "hidden", name: "authenticity_token", value: @controller.send(:form_authenticity_token))
            # generates a hidden input field that contains a CSRF (Cross-Site Request Forgery) token. This is a security measure that ensures the form submission is valid and not from a malicious source.
            # The widget accesses the token by calling the `form_authenticity_token` method on the `@controller` instance, which was passed in from the controller.
            # This is required because the widget, a standalone Ruby class, does not have direct access to the controller's helper methods.

            div(class: "mb-6") do
              label("Number of Containers:", for: "num_containers",
                                             class: "block text-sm font-medium text-gray-700 mb-2")
              input(type: "number", id: "num_containers", name: "num_containers", min: "1", required: true,
                    class: "w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500") do
              end
              div(class: "mb-6") do
                label("Container Size/Type", for: "container_type",
                                             class: "block text-sm font-medium text-gray-700 mb-2")
                select(id: "container_type", name: "container_type", required: true,
                       class: "w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500") do
                  option("Select a size...", value: "", disabled: true, selected: true)
                  # This is the first <option> in the dropdown. It acts as a placeholder or a prompt for the user. value: '': This option has an empty value.value: '': This option has an empty value. disabled: true: This makes the option unclickable. selected: true: This makes the option the default one shown when the page loads.
                  option("20ST", value: "20ST")
                  option("40ST", value: "40ST")
                  option("40HC", value: "40HC")
                  option("20RH", value: "20RH")
                  option("40RH", value: "40RH")
                end
              end

              div(class: "mb-6") do
                label "Include Charges:", class: "block text-sm font-medium text-gray-700 mb-2"
                %w[fas security_fee hazard unstuffing plugs_daily_rate].each do |charge|
                  # This is a core Ruby loop that makes the code efficient. is an array of strings, where each string corresponds to a type of charge. .each do |charge| iterates over this array one item at a time. In each iteration, the current string (e.g., 'fas', then 'security_fee') is assigned to the variable charge. This means the code inside the loop will run once for each type of charge.

                  div(class: "flex items-center mb-3") do
                    input(type: "checkbox", id: charge, name: charge,
                          class: "form-checkbox h-5 w-5 text-blue-600 rounded focus:ring-blue-500 border-gray-300")
                    label(charge.split("_").map(&:capitalize).join(" "), for: charge,
                                                                         class: "ml-3 text-sm text-gray-700")
                    # charge.split('_').map(&:capitalize).join(' '): This is a piece of Ruby code that takes the string from the loop (e.g., 'security_fee') and formats it to be a user-friendly label ("Security Fee"). It splits the string at the underscore, capitalizes each word, and then joins them back together with a space.
                  end
                end
              end

              div(class: "mb-6", id: "plugs-days-group") do
                label("Number of Days for Plugs:", for: "plugs_days",
                                                   class: "block text-sm font-medium text-gray-700 mb-2")
                input(type: "number", id: "plugs_days", name: "plugs_days", min: "0", value: "0",
                      class: "w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500")
              end
              button(type: "submit",
                     class: "w-full py-3 px-4 bg-blue-600 hover:bg-blue-700 text-white font-bold rounded-lg shadow-md transition-colors duration-300") do
                # This line generates the <button> tag. type: 'submit': This is a crucial attribute that tells the browser this button is meant to submit the form data to the server.
                text "Calculate Charges"
              end
            end

            if @result
              # This is a conditional statement. It checks if the @result instance variable has a value. The @result variable is only assigned a value when the post '/calculate' route is called after the form is submitted. This if block ensures that the total charge is only displayed after the calculation has been performed and a result is available, and not when the page is first loaded.
              div(class: "mt-8 p-6 bg-blue-50 rounded-lg") do
                h2(class: "text-2xl font-bold text-center text-gray-600 mb-4") do
                  text "Breakdown of Charges"
                end
                ul(class: "mb-4") do
                  # ul(class: 'mb-4') do: This creates an unordered list (<ul>) to hold the individual charge items.
                  @result[:breakdown].each do |charge_name, amount|
                    # @result[:breakdown].each do |charge_name, amount|: This is a key line that iterates through the breakdown hash
                    # charge_name, amount|: in each loop, the key (e.g., 'FAS') is assigned to the variable charge_name and the value (the calculated amount, e.g., 1221.98) is assigned to the variable amount.
                    li(class: "flex justify-between items-center py-2 border-b border-blue-200 last:border-b-0") do
                      # This creates a list item (<li>) for each charge.
                      span(class: "text-sm font-medium text-gray-600") do
                        # This creates a <span> to hold the charge name.
                        text charge_name
                      end
                      span(class: "text-sm font-semibold text-gray-600") do
                        # This creates another <span> to hold the amount. The classes style it with a slightly heavier font weight
                        text "BBD $%.2f" % amount
                        # "BBD $%.2f": is a Ruby format string. %.2f is the placeholder for a floating-point number, and the .2 specifies that it should be rounded to exactly two decimal places.
                        # % amount: This is the format operator. It tells Ruby to take the value of the amount variable and insert it into the placeholder in the string. The result is a clean, formatted string like "BBD $1221.98".
                      end
                    end
                  end
                end

                div(class: "text-lg font-semibold text-center text-gray-600 mt-4") do
                  text "Total Port Charges"
                  span(class: "text-2xl font-extrabold") do
                    # This line creates an inline <span> element. Since it's an inline element, it appears on the same line as the text that precedes it ("Total Port Charges"). This <span> is used to apply a different style specifically to the number, making it stand out from the rest of the line. The Tailwind classes are applied
                    text " BBD $%.2f" % @result[:total]
                  end
                end
              end
            end

            #---Return to Homepage and Return to Projects Buttons
            div(class: "my-8 text-center") do
              a(href: "/projects",
                class: "inline-block py-2 px-4 bg-blue-600 hover:bg-blue-700 text-white text-base font-bold rounded-lg shadow-md transition-colors duration-300") do
                text "Return to Projects"
              end
            end

            div(class: "my-8 text-center") do
              a(href: "/",
                class: "inline-block py-2 px-4 bg-blue-600 hover:bg-blue-700 text-white text-base font-bold rounded-lg shadow-md transition-colors duration-300") do
                text "Return to Homepage"
              end
            end
          end
        end
      end
    end
  end
end
