module Blog
  module Admin
    module Posts
      class Form < Phlex::HTML
        include Phlex::Rails::Helpers::Routes
        def initialize(post:, url:, method: "post")
          @post = post
          @url = url
          @method = method
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
              main(class: "max-w-3xl mx-auto pt-28") do
                h1(class: "text-4xl sm:text-5xl font-bold mb-6") { @post.new_record? ? "New Post" : "Edit Post" }
                # @post is an ActiveRecord model. @post.new_record? is a method which returns true if the object hasn't been saved to the data base or false if the objject is already persisted.
                # the ? after the @post.new_record? is Ruby's ternary operator. It's used here to decide which test to render based on what the method returns.
                # so if true, the text rendered will be "New Post". If false, then "Edit Post"

                # ==============================
                # ---Form for Create/Update-----
                # ==============================
                form(action: @url, method: "post", class: "space-y-4") do
                  input(type: "hidden", name: "authenticity_token", value: view_context.form_authenticity_token)
                  if @method != "post"
                    input type: "hidden", name: "_method", value: @method
                  end
                  # action: @url - where the form will be submitted to comes from the @url instance variable which is defined for each method (index, new, create, edit, update and destroy) in the posts_controller and passed in when the form phlex component is rendered by the controller
                  # method: "post" because browsers only accept the methods POST and GET. So even if we need a PATCH (update), we have to use the Rails workaround:
                  # For new posts, @method = "post" (no hidden field needed).
                  # For editing posts, @method = "patch". Rails sees _method=patch when the controller renders it and treats the request as a PATCH.

                  # The controller decides whether we’re creating or editing by passing url and method into the form.
                  # The form then builds the correct <form> tag and hidden fields.
                  # The .new_record? flag tells the form how to label buttons and headers.

                  div do
                    label(for: "blog_post_title", class: "block font-semibold mb-1") { "Title" }
                    input type: "text", name: "blog_post[title]", id: "post_title",
                    value: @post.title, class: "w-full border px-3 py-3 py-2 rounded"
                  end

                  div do
                    label(for: "blog_post_body", class: "block font-semibold mb-1") { "Body" }
                    textarea(name: "blog_post[body]", id: "post_body",
                    class: "w-full border px-3 py-2 rounded h-64") { @post.body }
                  end

                  button(type: "submit", class: "px-4 py-2 bg-black text-white font-semibold rounded hover:bg-gray-800 transition") do
                    @post.new_record? ? "Create Post" : "Update Post"
                  end
                end

                # ============================================
                # ---Form for Delete (only for existing posts)
                # ============================================
                unless @post.new_record?
                  form(action: blog_admin_post_path(@post), method: "post", class: "mt-4") do
                    input(type: "hidden", name: "authenticity_token", value: view_context.form_authenticity_token)
                    input(type: "hidden", name: "_method", value: "delete")
                    button(type: "submit", class: "px-4 py-2 bg-red-600 text-white font-semibold rounded hover:bg-red-800 transition") do
                      "Delete Post"
                    end
                  end
                end

                # ---Back link------
                a(href: blog_admin_posts_path, class: "inline-block mt-6 text-base sm:text-lg text-black hover:text-gray-600") do
                  "Back to Posts"
                end
              end
            end
          end
        end
      end
    end
  end
end
