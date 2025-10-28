class TdeeCalculator < Phlex::HTML
  include Phlex::Rails::Helpers::Routes

  def initialize(tdee: nil, weight: nil, height: nil, age: nil, sex: nil, activity_level: nil)
    @tdee = tdee
    @weight = weight
    @height = height
    @age = age
    @sex = sex
    @activity_level = activity_level
  end

  def view_template
    html do
      head do
        title { "TDEE Calculator" }
        meta(charset: "UTF-8")
        meta(name: "viewport", content: "width=device-width, initial-scale=1.0")

        link(rel: "preconnect", href: "https://fonts.googleapis.com")
        link(rel: "preconnect", href: "https://fonts.gstatic.com", crossorigin: "anonymous")
        link(rel: "stylesheet", href: "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css")
        link(href: "https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap",
        rel: "stylesheet")

        # CSS code to add custom font
        style do
          raw "html, body { font-family: 'Montserrat', sans-serif !important; }".html_safe
        end
      end

      body(class: "bg-slate-100 min-h-screen p-4 sm:p-8") do
        render Blog::Components::Navbar.new
        h1(class: "text-2xl sm:text-3xl md:text-4xl lg:text-5xl font-bold text-center text-slate-800 mt-10 mb-10 md:mb-20") do
          "Total Daily Energy Expenditure Calculator"
        end

        div(class: "space-y-4 w-full max-w-md sm:max-w-lg md:max-w-2xl mx-auto p-4 sm:p-6 md:p-8 bg-white rounded-xl shadow-xl") do
          # form starts here
          form(
            action: tdee_calculator_path,
            method: "post",
            class: "space-y-6"
          ) do
            # CSRF token
            input(type: "hidden", name: "authenticity_token", value: view_context.form_authenticity_token)

            # weight
            div do
              label(for: "weight", class: "block font-medium text-gray-700 mb-1") { "Weight (kg)" }
              input(
                type: "number",
                name: "weight",
                id: "weight",
                step: "any",
                value: @weight,
                class: "w-full border border-gray-300 rounded-lg p-2 focus:outline-none focus:ring focus:border-blue-300"
              )
            end

            # height
            div do
              label(for: "height", class: "block font-medium text-gray-700 mb-1") { "Height (cm)" }
              input(
                type: "number",
                name: "height",
                id: "height",
                step: "any",
                value: @height,
                class: "w-full border border-gray-300 rounded-lg p-2 focus:outline-none focus:ring focus:border-blue-300"
              )
            end

            # age
            div do
              label(for: "age", class: "block font-medium text-gray-700 mb-1") { "Age" }
              input(
                type: "number",
                name: "age",
                id: "age",
                step: "any",
                value: @age,
                class: "w-full border border-gray-300 rounded-lg p-2 focus:outline-none focus:ring focus:border-blue-300"
              )
            end

            # sex
            div do
              label(for: "sex", class: "block font-medium text-gray-700 mb-1") { "Sex" }
              select(name: "sex", id: "sex", class: "w-full border border-gray-300 rounded-lg p-2") do
                option(value: "male", selected: @sex == "male") { "Male" }
                option(value: "female", selected: @sex == "female") { "Female" }
              end
            end

            # activity level
            div do
              label(for: "activity level", class: "block font-medium text-gray-700 mb-1") { "Activity Level" }
              select(name: "activity_level", id: "activity_level", class: "w-full border border-gray-300 rounded-lg p-2") do
                option(value: "sedentary", selected: @activity_level == "sedentary") { "Sedentary" }
                option(value: "light", selected: @activity_level == "light") { "Light" }
                option(value: "moderate", selected: @activity_level == "moderate") { "Moderate" }
                option(value: "very_active", selected: @activity_level == "very_active") { "Very Active" }
                option(value: "extra_active", selected: @activity_level == "extra_active") { "Extra Active" }
              end
            end

            # submit button
            button(type: "submit", class: "w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 rounded-lg") { "Calculate" }

            # ---RENDER THE RESULT COMPONENET HERE---
            # even if @tdee is nil, this renders the outer div(id: "tdee_result"), which is essential for Turbo Streams to target it.
            render TdeeResult.new(tdee: @tdee)
            # ---------------------------------------
          end
        end
      end
    end
  end
end
