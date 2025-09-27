class Blog::Posts::Show < Phlex::HTML
  def initialize(post:)
    @post = post
  end

  def template
    html do
      head do
        title { @post.title }
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

      body(class: "bg-white text-black px-4 sm:px-6 lg:px-8") do
        main(class: "max-w-3xl mx-auto pt-20") do
          h1(class: "text-3xl sm:text-5xl font bold mb-6") { @post.title }
          p(class: "text-sm sm:text-base text-gray-500 mb-8") { @post.created_at.strftime("%B %d %Y") }

          div(class: "prose prose-sm sm:prose lg:prose-lg max-w-none text-black") do
            rawtext @post.body
          end
          a(href: blog_posts_path, class: "inline-block mt-10 text-base sm:text-lg font-semibold text-black hover:text-gray-600") do
            text "Back to Blog"
          end
        end
      end
    end
  end
end
