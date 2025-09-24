class Blog::Posts::Show < Phlex::HTML
  def initialize(post:)
    @post = post
  end

  def template
    html do
      head do
        title "Home Page"
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
      
  end
end
