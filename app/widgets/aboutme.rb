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
            a(href: "/projects", class: "text-lg hover:text-gray-300 transition-colors") { text "Web Apps" }
            a(href: "/blog/posts", class: "text-lg hover:text-gray-300 transition-colors") { text "Blog" }
            a(href: "/resume", class: "text-lg hover:text-gray-300 transition-colors") { text "Resume" }
          end
        end

        # Mobile menu (hidden by default)
        div(id: "mobile-menu",
            class: "hidden md:hidden bg-black text-white w-full fixed top-16 left-0 right-0 z-40 px-6 py-4") do
          div(class: "flex flex-col space-y-4 text-center") do
            a(href: "/about", class: "text-lg hover:text-gray-300 transition-colors") { text "About Me" }
            a(href: "/projects", class: "text-lg hover:text-gray-300 transition-colors") { text "Web Apps" }
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
                text "I was born and raised in Barbados and my path in life has taken some twists and turns. I began in the humanities, completing my BA (First Class Honors) in Theology and then moved to Finland where I completed my MPhil (Laudatur) in Religious Studies. After this, I lived and worked on an organic farm in the Finnish countryside— surrounded by forests, lakes and the rhythmns of the seasons. The experience grounded me, brought me closer to nature, connected me with my own body and changed how I saw myself and the world."
              end
              p(class: "text-base font-medium mb-4") do
                text "During that time, I started to take my physical fitness seriously. When I moved back to the city, I threw myself into training Brazilian Jiu-Jitsu, which quickly become a central part of my life. Eventually I returned home to Barbados to be closer to my family and the sun."
              end
              p(class: "text-base font-medium mb-4") do
                text "Since moving back home, I've worked in a corporate setting as an administrative officer and then a customs broker. While I excelled as a customs broker, and took whatever steps I could to find a balance and mitigate the toll which the corporate environment takes on human health, I realized after a year in that it didn't align with the kind of life I wanted to build for myself. So I made the decision to step away and focus on what truly drives me: nutrition and health."
              end
              p(class: "text-base font-medium mb-4") do
                text "Over years of self-directed learning, I've explored how nutrition, circadian biology, and lifestyle interact to shape human health. I've spent countless hours reviewing primary literature on PubMed and Google Scholar and I'm constantly tracking key health markers and experimenting with data-informed strategies to refine and improve them over time. However, now I am finally pursuing formal education in the field, preparing to do an MSc in Clinical Nutrition."
              end
              p(class: "text-base font-medium mb-4") do
                text "I'm also a technology enthusiast and long time user of Linux with a strong appreciation for free open source software. Lately I've been teaching myself to program in Ruby —learning by building. I began with tools to streamline my work as a customs broker and progressed onto other apps which I have a use for in my daily life. This website and all of the web apps featured here were written in Ruby"
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
