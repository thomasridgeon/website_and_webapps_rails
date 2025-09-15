class Journal::Notes < Journal::BaseWidget
  needs :Notes

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
            end
          end
        end
      end
    end
  end
end
