module Blog
  module Components
    class Navbar < Phlex::HTML
      def view_template
        #---Nav bar---
        nav(class: "bg-black text-white font-semibold w-full px-6 py-4 flex justify-between items-center fixed top-0 left-0 right-0 shadow-md z-50") do
          # Left Side
          div do
            a(href: "/", class: "text-lg hover:text-gray-300 transition-colors") do
              "Home"
            end
          end

          # Hamburger button (mobile only- mobile_menu_toggle.js in app/javascript)
          button(
            id: "mobile-toggle",
            class: "md:hidden focus:outline-none"
          ) do
            raw <<-SVG.html_safe
              <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
              </svg>
            SVG
          end

          # Right Side (desktop menu only)
          div(class: "hidden md:flex space-x-6") do
            a(href: "/about", class: "text-lg hover:text-gray-300 transition-colors") { "About Me" }
            a(href: "/projects", class: "text-lg hover:text-gray-300 transition-colors") { "Projects" }
            a(href: "/blog/posts", class: "text-lg hover:text-gray-300 transition-colors") { "Blog" }
            a(href: "/resume", class: "text-lg hover:text-gray-300 transition-colors") { "Resume" }
          end
        end

        # Mobile menu (hidden by default)
        div(id: "mobile-menu",
            class: "hidden md:hidden bg-black text-white w-full fixed top-16 left-0 right-0 z-40 px-6 py-4") do
          div(class: "flex flex-col space-y-4 text-center") do
            a(href: "/about", class: "text-lg hover:text-gray-300 transition-colors") { "About Me" }
            a(href: "/projects", class: "text-lg hover:text-gray-300 transition-colors") { "Projects" }
            a(href: "/blog/posts", class: "text-lg hover:text-gray-300 transition-colors") { "Blog" }
            a(href: "/resume", class: "text-lg hover:text-gray-300 transition-colors") { "Resume" }
          end
        end
        #----------------
      end
    end
  end
end
