class TdeeCalculator < Phlex::HTML
  def initialize(tdee: nil, weight: nil, height: nil, age: nil, sex: nil, activity_level: nil)
    @tdee = tdee
    @weight = weight
    @height = height
    @age = age
    @sex = sex
    @activity_level = activity_level
  end

  def view_template
    html do
      head do
        title { "TDEE Calculator" }
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
      
      body(class: "bg-slate-100 min-h-screen p-4 sm:p-8") do
        render Blog::Components::Navbar.new
        h1(class: "text-2xl sm:text-3xl md:text-4xl lg:text-5xl font-bold text-center text-slate-800 mt-10 mb-10 md:mb-20") do
          "TDEE Calculator"
        end


      end
  end
end