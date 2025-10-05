module Blog
  module Sessions
    class New < Phlex::HTML
       include Phlex::Rails::Helpers::Flash
       include Phlex::Rails::Helpers::Routes
      def view_template
        html do
          head do
            title { "Admin Login" }
            meta(charset: "UTF-8")
            meta(name: "viewport", content: "width=device-width, initial-scale=1.0")

            link(rel: "preconnect", href: "https://fonts.googleapis.com")
            link(rel: "preconnect", href: "https://fonts.gstatic.com", crossorigin: "anonymous")
            link(rel: "stylesheet", href: "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css")
            link(href: "https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap", rel: "stylesheet")

            # CSS code to add custom font
            style do
              raw "html, body { font-family: 'Montserrat', sans-serif !important; }".html_safe
            end
          end

          body(class: "bg-white text-black min-h-screen flex items-center justify-center px-4 sm:px-6 lg:px-8") do
            render Blog::Components::Navbar.new
            main(class: "max-w-md w-full space-y-8") do
              if flash[:alert]
                div(class: "bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded") do
                  flash[:alert]
                end
              end
              h1(class: "text-center text-3xl sm:text-4xl font-bold") { "Admin Login" }

              form(action: blog_login_path, method: "post", class: "mt-8 space-y-6") do
                input(type: "hidden", name: "authenticity_token", value: view_context.form_authenticity_token)
                div(class: "space-y-4") do
                  div do
                    label(for: "username", class: "block text-sm font-semibold") { "Username" }
                    input type: "text", name: "username", id: "username", required: true, class: "appearance-none rounded w-full px-3 py-2 border focus:outline-none focus:ring-2 focus:ring-black"
                  end
                  div do
                    label(for: "password", class: "block text-sm font-semibold") { "Password" }
                    input type: "password", name: "password", id: "password", required: true, class: "appearance-none rounded w-full px-3 py-2 border focus:outline-none focus:ring-2 focus:ring-black"
                  end
                end
                button(type: "submit", class: "w-full py-2 px-4 bg-black text-white font-semibold rounded hover:bg-gray-800 transition") do
                 "Log In"
                end
              end
            end
          end
        end
      end
    end
  end
end
