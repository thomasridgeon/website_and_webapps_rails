class Signup < Erector::Widget
  needs :controller
  needs :error_message
  def content
    html do
      head do
        meta(charset: "UTF-8")
        meta(name: "viewport", content: "width=device-width, initial-scale=1.0")
        # meta(charset: 'UTF-8'): This line generates the <meta charset="UTF-8"> tag. This is crucial for web browsers to correctly display characters from different languages.
        # meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0'): This generates a meta tag that is essential for making the page responsive and look good on mobile devices. It tells the browser to match the page's width to the device's screen width.
        title "Sign Up"

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

      body(class: "flex items-center justify-center min-h-screen p-4 relative") do
        # top-left link back to projects
        div(class: "absolute top-4 left-4") do
          a(href: "/projects", class: "text-sm text-gray-800 hover:underline bg-transparent border-0 cursor-pointer") { text "Return to Web Apps" }
        end
        # parent container
        div(class: "w-full max-w-md bg-white p-6 rounded-lg shadow-md") do
          h2(class: "text-2xl sm:text-3xl font-bold mb-6 text-center text-black") { text "Sign Up" }

          # error message (if present)
          if @error_message
            div(class: "mb-4 p-2 bg-red-100 border border-red-400 text-red-700 rounded") do
              text @error_message
            end
          end

          form(action: "/journal/signup", method: "post", class: "space-y-4") do
            input(type: "hidden", name: "authenticity_token", value: @controller.send(:form_authenticity_token))
            # Username
            div do
              label(for: "username", class: "block mb-1 font-medium") { text "Username" }
              input(type: "text", name: "username", id: "username",
                    class: "border rounded w-full p-2 focus:outline-none focus:ring-2 focus:ring-blue-400")
            end
            # Password
            div do
              label(for: "password", class: "block mb-1 font-medium") { text "Password" }
              input(type: "password", name: "password", id: "password",
                    class: "border rounded w-full p-2 focus:outline-none focus:ring-2 focus:ring-blue-400")
            end
            # Submit button
            div do
              input(type: "submit", value: "Sign Up",
                    class: "bg-blue-500 text-white font-semibold px-4 py-2 rounded w-full sm:w-auto hover:bg-blue-600 cursor-pointer")
            end
          end
          div(class: "mt-4 text-center text-gray-700 text-sm") do
            text "Already have an account? "
            a(href: "/journal/login", class: "text-blue-500 hover:text-blue-700 font-medium") { text "Login here" }
          end
        end
      end
    end
  end
end
