class Journal::Notes < Journal::BaseWidget
  needs :notes, :controller
  # In Erector, needs is how you declare what inputs a widget expects from the outside world. It’s essentially a contract between the widget and whoever instantiates it.
  # I declare needs :controller in an Erector widget if the widget needs access to the Rails controller instance.
  # needs :notes means “This widget expects to be given a collection of notes when it’s created.”
  # Whoever calls the widget has to provide this- Journal::Notes.new(notes: @notes, controller: self), for example when I render the widget
  # When I declare needs :controller, Erector automatically creates an instance variable @controller inside the widget.
  # When I declare needs :notes, Erector automatically creates an instance variable @notes inside the widget.

  def content
    page("Your Journal") do
      h2(class: "text-xl sm:text-xl-2 font-semibold mb-10 text-black text-center") { text "#{@controller.current_user.username}'s Journal" }

      div(class: "mb-10 text-center") do
        a(href: "/journal/notes/new", class: "bg-black text-white px-2 py-2 rounded hover:bg-gray-800") { text "New Note" }
      end

      if @notes.any?
        ul(class: "space-y-4") do
          @notes.each do |note|
            li(class: "p-4 border rounded") do
              a(href: "/journal/notes/#{note.id}", class: "text-lg font-semibold text-black hover:underline") do
                text "Note##{note.id}"
              end

              div(class: "mt-2 space-x-4") do
                a(href: "/journal/notes/#{note.id}/edit", class: "text-blue-500 hover:underline") { text "Edit" }

                form(action: "/journal/notes/#{note.id}", method: "post", class: "inline") do
                  input(type: "hidden", name: "authenticity_token", value: @controller.send(:form_authenticity_token))
                  input(type: "hidden", name: "_method", value: "delete")
                  input(type: "submit", value: "Delete", class: "text-red-500 hover:underline bg-transparent border-0 cursor-pointer")
                end
              end
            end
          end
        end
      else
        p(class: "text-center text-gray-500") { text "No notes yet. Create one above." }
      end
    end
  end
end
