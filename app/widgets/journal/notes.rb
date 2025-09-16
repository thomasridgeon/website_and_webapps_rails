class Journal::Notes < Journal::BaseWidget
  needs :notes

  def content
    page("Your Journal") do
      h2(class: "text-2xl font-bold mb-4 text-black text-center") { text "Your Journal" }

      div(class: "mb-4 text-right") do
        a(href: "/journal/notes/new", class: "bg-black text-white px-4 py-2 rounded hover:bg-gray-800") { text "New Note" }
      end

      if notes.any?
        ul(class: "space-y-4") do
          notes.each do |note|
            li(class: "p-4 border rounded") do
              a(href: "/journal/notes/#{note.id}", class: "text-lg font-semibold text-black hover:underline") do
                text "Note##{note.id}"
              end

              div(class: "mt-2 space-x-4") do
                a(href: "/journal/notes/#{note.id}/edit", class: "text-blue-500 hover:underline") { text "Edit" }
                a(href: "journal/notes/#{note.id}",
                  "data-method" => "delete",
                  "data-confirm" => "Are you sure?",
                  class: "text-red-500 hover:underline") { text "Delete" }
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
