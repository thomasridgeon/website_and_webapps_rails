class Journal::BaseWidget < Erector::Widget
  needs :controller

  def page(title, &block)
    html do
      head do
        meta(charset: "UTF-8")
        meta(name: "viewport", content: "width=device-width, initial-scale=1.0")
        # meta(charset: 'UTF-8'): This line generates the <meta charset="UTF-8"> tag. This is crucial for web browsers to correctly display characters from different languages.
        # meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0'): This generates a meta tag that is essential for making the page responsive and look good on mobile devices. It tells the browser to match the page's width to the device's screen width.
        title "Journal Landing"

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

      body(class: "min-h-screen p-4 flex flex-col items-center") do
        # Nav row
        div(class: "w-full max-w-3xl flex items-center justify-between mb-6") do
          a(href: "/journal", class: "text-lg font-semibold text-black") { text "Encrypted Journal" }
          div(class: "flex items-center") do
            a(href: "/journal/notes", class: "mr-4 text-sm text-gray-700 hover:underline") { text "Notes" }
            if @controller && @controller.respond_to?(:current_user) && @controller.current_user
              # if controller - checks if the controller object exists
              # && controller.respond_to?(:current_user) - checks the controller object has a method named current_user
              # controller.current_user - finally, it calls current_user and checks if it returns something truthy (a user object if logged in, or nil if not)
              span(class: "mr-4 text-sm text-gray-500") { text @controller.current_user.username }
              form(action: "/journal/logout", method: "post", class: "inline") do
                input(type: "hidden", name: "authenticity_token", value: @controller.send(:form_authenticity_token))
                input(type: "hidden", name: "_method", value: "delete")
                input(type: "submit", value: "Logout", class: "text-sm text-red-600 hover:underline bg-transparent border-0 cursor-pointer")
              end
            else
              a(href: "/journal/login", class: "text-sm text-gray-700 hover:underline") { text "Login" }
            end
          end
        end
        # page content container
        div(class: "w-full max-w-3xl") do
          div(class: "bg-white shadow-md rounded-lg p-6") do
            block.call if block
            # BaseWidget defines the outer shell (page <html>, <body>, container <div>s, shared CSS).
            # block.call is the placeholder where the page-specific content (from NotesIndex, Signup, Login, etc.) gets injected.
          end
        end
      end
    end
  end
end
