module Blog
  module Posts
    class Index < Phlex::HTML
      include Phlex::Rails::Helpers::Routes
      def initialize(posts:)
        @posts = posts
      end

      def view_template
        html do
          head do
            title { "Blog Posts Index" }
            meta(charset: "UTF-8")
            meta(name: "viewport", content: "width=device-width, initial-scale=1.0")

            link(rel: "preconnect", href: "https://fonts.googleapis.com")
            link(rel: "preconnect", href: "https://fonts.gstatic.com", crossorigin: "anonymous")
            link(rel: "stylesheet", href: "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css")
            link(href: "https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap",
             rel: "stylesheet")

            # CSS code to add custom font
            style do
              raw "html body { font family: 'Montserrat', sant-serif !important; }".html_safe
            end
          end

          body(class: "bg-white text-black px-4 sm:px-6 lg:px-8") do
            render Blog::Components::Navbar.new
            main(class: "max-w-3xl mx-auto pt-20") do
              h1(class: "text-4xl sm:text-5xl font-bold mb-10 text-center") { "Blog" }
                ul(class: "space-y-8") do
                  @posts.each do |post|
                  li(class: "border-b pb-6") do
                    a(href: blog_post_path(post), class: "block text-2xl sm:text-3xl font-semibold hover-gray-600 transition-colors") do
                      post.title
                    end
                    p(class: "text-sm sm:text-base text-gray-500 mt-2") { post.created_at.strftime("%B %d %Y") }
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
