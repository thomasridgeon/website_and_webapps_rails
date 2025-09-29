module Blog
  module Admin
    module Posts
      class Blog::Admin::Posts::Index < Phlex::HTML
        include Phlex::Rails::Helpers::Routes
        def initialize(posts:)
          @posts = posts
        end

        def view_template
          html do
            head do
              title { "Blog Admin Posts Index" }
              meta(charset: "UTF-8")
              meta(name: "viewport", content: "width=device-width, initial-scale=1.0")

              link(rel: "preconnect", href: "https://fonts.googleapis.com")
              link(rel: "preconnect", href: "https://fonts.gstatic.com", crossorigin: "anonymous")
              link(rel: "stylesheet", href: "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css")
              link(href: "https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap",
              rel: "stylesheet")

              # CSS code to add custom font
              style do
                raw "html, body { font-family: 'Montserrat', sans-serif !important; }".html_safe
              end
            end

            body(class: "bg-white text-black px-4 sm:px-6 lg:px-8 min-h-screen") do
              main(class: "max-w-4xl mx-auto pt-20") do
                h1(class: "text-4xl sm:text-5xl font-bold mb-8 text-center") { "Admin Blog Posts" }

                a(href: "/blog/admin/posts/new", class: "inline-block mb-6 px-4 py-2 bg-black text-white font-semibold rounded hover:bg-grey-800 transition") do
                  "New Post"
                end

                ul(class: "space-y-4") do
                  @posts.each do |post|
                    li(class: "flex flex-col sm:flex-row justify-between items-start sm:items-center border-b pb-4") do
                      a(href: blog_post_path(post), class: "text-2xl font-semibold hover:text-gray-600") { post.title }

                      div(class: "mt-2 sm:mt-0 space-x-2") do
                        a(href: "/blog/admin/posts/#{post.id}/edit", class: "text-blue-600 hover:underline") { "Edit" }

                        form(action: "/blog/admin/posts/#{post.id}", method: "post", class: "inline") do
                          input type: "hidden", name: "_method", value: "delete"
                          button(type: "submit", class: "text-red-600 hover:underline") { "Delete" }
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
    end
  end
end
