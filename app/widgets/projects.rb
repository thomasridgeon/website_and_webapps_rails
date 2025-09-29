#---PROJECTS PAGE-------------------------------
class Projects < Erector::Widget
  def content
    rawtext "<!DOCTYPE html>"
    html do
      head do
        title "Projects - Thomas Ridgeon"
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
      end # closes head do

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

        div(class: "max-w-2xl p-4 sm:p-6 flex flex-col items-start mx-4 sm:mx-auto") do
          h1(class: "text-3xl sm:text-5xl font-bold mt-24 sm:mt-28 mb-6 sm:mb-10") do
            text "My Projects"
          end
          a(href: "/portcharges", class: "text-lg sm:text-xl font-bold hover:text-gray-300 transition-colours") do
            text "Port Charges Calculator"
          end
          p(class: "text-sm sm:text-base mb-4") do
            text "This is the first web app I coded. It's one of the customs broker tools I had originally created with Replit. I then re-wrote it in Ruby. It's an app which I use daily as a customs broker in Barbados to calculate Barbados Port Charges."
          end
          a(href: "/solardcalculator", class: "text-lg sm:text-xl font-bold hover:text-gray-300 transition-colours") do
            text "Solar D Calculator"
          end
          p(class: "text-sm sm:text-base mb-4") do
            text "A web app to tell you the current UV index of the sun in your region as well as calculate, based on your age and skin type, the amount of time you would have to be outside with at least 25% of your body exposed to synthesize an optimum daily amount of vitamin D (1,000 IU)."
          end
          a(href: "/journal", class: "text-lg sm:text-xl font-bold hover:text-gray-300 transition-colours") do
            text "Encrypted Journal"
          end
          p(class: "text-sm sm:text-base mb-4") do
            text "A secure note-taking app that uses AES-256 encryption to keep your data private. " \
                 "Create, edit, and delete notes with titles and bodies, knowing your personal journal stays protected—even if the database is compromised. Sign up with just a username and password. " \
                 "The app generates a unique randomly generated salt for each user. " \
                 "An AES encryption key is derived from the user's password + salt via PBKDF2. " \
                 "The AES key is re-derived on login using the stored salt and entered password, which are hashed via bcrypt and stored in the database as a password_hash and never plaintext. " \
                 "The AES key itself is never stored in the database, but only temporarily stored in the session as an encrypted cookie. " \
          end
          a(href: "/brokertoolkit", class: "text-lg sm:text-xl font-bold hover:text-gray-300 transition-colours") do
            text "Customs Broker Toolkit"
          end
          p(class: "text-sm sm:text-base mb-4") do
            text "A collection of tools which I use daily as a customs broker in Barbados. Quickly convert currencies using official Barbados Customs rates, and calculate collect freight along with foreign exchange charges in Barbados dollars."
          end
        end
      end
    end
  end
end
