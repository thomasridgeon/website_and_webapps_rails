#---About Page Widget-----------
class Aboutme < Erector::Widget
  def content
    rawtext "<!DOCTYPE html>"
    html do
      head do
        title "About Me - Thomas Ridgeon"
        meta(charset: "UTF-8")
        meta(name: "viewport", content: "width=device-width, initial-scale=1.0")

        link(rel: "preconnect", href: "https://fonts.googleapis.com")
        link(rel: "preconnect", href: "https://fonts.gstatic.com", crossorigin: "anonymous")
        link(rel: "stylesheet", href: "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css")
        link(href: "https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap",
             rel: "stylesheet")

        # CSS code to add custom font
        style do
          rawtext <<-CSS
            html, body {
              font-family: 'Montserrat', sans-serif !important;
            }
          CSS
        end
      end

      body(class: "bg-white text-black") do
        #---Nav bar---
        nav(class: "bg-black text-white font-semibold w-full px-6 py-4 flex justify-between items-center fixed top-0 left-0 right-0 shadow-md z-50") do
          # Left Side
          div do
            a(href: "/", class: "text-lg hover:text-gray-300 transition-colors") do
              text "Home"
            end
          end

          # Hamburger button (mobile only)
          button(
            class: "md:hidden focus:outline-none",
            onclick: "document.getElementById('mobile-menu').classList.toggle('hidden')"
          ) do
            # SVG icon (hamburger lines)
            rawtext <<-SVG
              <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
              </svg>
            SVG
          end

          # Right Side (desktop menu only)
          div(class: "hidden md:flex space-x-6") do
            a(href: "/about", class: "text-lg hover:text-gray-300 transition-colors") { text "About Me" }
            a(href: "/projects", class: "text-lg hover:text-gray-300 transition-colors") { text "Projects" }
            a(href: "/blog/posts", class: "text-lg hover:text-gray-300 transition-colors") { text "Blog" }
            a(href: "/resume", class: "text-lg hover:text-gray-300 transition-colors") { text "Resume" }
          end
        end

        # Mobile menu (hidden by default)
        div(id: "mobile-menu",
            class: "hidden md:hidden bg-black text-white w-full fixed top-16 left-0 right-0 z-40 px-6 py-4") do
          div(class: "flex flex-col space-y-4 text-center") do
            a(href: "/about", class: "text-lg hover:text-gray-300 transition-colors") { text "About Me" }
            a(href: "/projects", class: "text-lg hover:text-gray-300 transition-colors") { text "Projects" }
            a(href: "/blog/posts", class: "text-lg hover:text-gray-300 transition-colors") { text "Blog" }
            a(href: "/resume", class: "text-lg hover:text-gray-300 transition-colors") { text "Resume" }
          end
        end
        #----------------

        #---Main content-----

        div(class: "max-w-5xl mx-auto flex flex-col md:flex-row items-center gap-10 mt-20") do
          div(class: "order-1 md:order-2 flex-shrink-0") do
            img(src: "/images/myphoto.jpg", alt: "My Photo",
                class: "w-48 h-48 sm:w-80 sm:h-80 rounded-full mx-auto mb-2 md:mb-0")
          end

          div(class: "order-2 md:order-1 flex-1 flex flex-col justify-center text-center md:text-left p-6 md:p-0") do
            div(class: "max-w-prose") do
              h1(class: "text-5xl font-bold mt-0 mb-8") do
                text "About Me"
              end
              p(class: "text-base font-medium mb-4") do
                text "I'm a multidisciplinary professional with a unique blend of experience across logistics, administration, academic research, and health & fitness.  I hold a BA (First Class Honours) in Theology and an MPhil (Laudatur) in Religious Studies."
              end
              p(class: "text-base font-medium mb-4") do
                text "I currently work as a Customs Broker, but my enduring passion lies in health optimization. Over years of self-directed learning, I've explored how nutrition, metabolism, circadian biology, pharmacology, and behaviour interact to shape health. Building on the research and analytical skills developed through my academic studies, I’ve spent countless hours reviewing primary literature on PubMed and Google Scholar. I am constantly tracking key health markers and experimenting with data-informed strategies to refine and improve them over time."
              end
              p(class: "text-base font-medium mb-4") do
                text "I'm also a technology enthusiast and hope to combine this interest with my passion for health optimization. I've been teaching myself to program in Ruby - learning by building. I started with practical tools to streamline my work as a customs broker, but my deeper motivation is to create digital health tools to help people make informed, measurable improvements to their health."
              end
              #---Social Media Icons---
              div(class: "flex space-x-4 mt-6 justify-center md:justify-start") do
                a(href: "https://github.com/thomasridgeon", target: "_blank") do
                  img(src: "/images/github-mark.png", alt: "GitHub Profile", class: "w-10 h-10")
                end
                a(href: "https://linkedin.com/in/thomas-ridgeon-72b455370", target: "_blank") do
                  img(src: "/images/InBug-Black.png", alt: "LinkedIn Profile", class: "w-10 h-10")
                end
              end
            end
          end
        end
      end
    end
  end
end
