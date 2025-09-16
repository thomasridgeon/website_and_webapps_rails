class Journal::Note < Journal::BaseWidget
  needs :plaintext, :note_id

  def content
    page("Note") do
      h2(class: "text-2xl font-bold mb-4 text-black text-center") { text "Note" }

      # preserve new lines and spacing
      div(class: "prose prose-lg text-black whitespace-pre-wrap") do
        text plaintext
      end

      div(class: "mt-6 flex justify-between") do
        a(href: "/journal/notes", class: "text-gray-500 hover:underline") { text "Back" }
        a(href: "/journal/notes/#{note_id}/edit", class: "text-blue-500 hover:underline") { text "Edit" }
      end
    end
  end
end
