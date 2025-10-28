class Journal::Landing < Erector::Widget
  needs :controller
  def content
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

      body(class: "flex items-center justify-center min-h-screen p-4 relative") do
        # top-left link back to projects
        div(class: "absolute top-4 left-4") do
          a(href: "/projects", class: "text-sm text-gray-800 hover:underline bg-transparent border-0 cursor-pointer") { text "Return to Web Apps" }
        end
        # parent container
        div(class: "w-full max-w-md bg-white p-6 rounded-lg shadow-md mt-10") do
          h2(class: "text-3xl sm:text-4xl font-bold mb-10 text-center text-black") { text "Encrypted Journal" }
          img(src: "/images/journal.png", alt: "journal logo",
              class: "w-24 h-24 sm:w-32 sm:h-32 rounded-full mx-auto mb-2 md:mb-0")
          p(class: "text-base sm:text-lg font-normal mb-10 text-center text-gray-600") do
            text "A private, encrypted journal that keeps your entries safe with AES-256 encryption- accessible only to you."
          end
          div(class: "flex flex-col items-center") do
            div(class: "mb-4") do
              a(href: "/journal/login",
                class: "inline-block py-2 px-4 bg-black hover:bg-gray-700 text-white text-base font-bold rounded-lg shadow-md transition-colors duration-300") do
                  text "Log in"
              end
            end
            div(class: "mt-4") do
              a(href: "/journal/signup",
                class: "inline-block py-2 px-4 bg-black hover:bg-gray-700 text-white text-base font-bold rounded-lg shadow-md transition-colors duration-300") do
                  text "Sign up"
              end
            end
          end
         end
        end
      end
  end
end
