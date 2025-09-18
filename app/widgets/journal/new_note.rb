class Journal::NewNote < Journal::BaseWidget
  needs :controller
  def content
    page("New Note") do
      h2(class: "text-2xl font-bold mb-4 text-black text-center") { text "New Note" }

      form(action: "/journal/notes", method: "post", class: "space-y-4") do
        input(type: "hidden", name: "authenticity_token", value: @controller.send(:form_authenticity_token))

        # title input field
        div do
          label(for: "title", class: "block text-sm font-medium text-gray-700") { text "Title" }
          input(type: "text", name: "title", id: "title",
                class: "w-full border rounded p-2 focus:outline-none focus:ring-2 focus:ring-blue-400", placeholder: "Enter a title...")
        end

        # body text area
        div do
          textarea(name: "body", rows: 12,
            class: "w-full border rounded p-3 focus:outline-none focus:ring-2 focus:ring-blue-400",
            placeholder: "Write your note here...")
        end

        # action buttons
        div(class: "flex justify-end space-x-4") do
          a(href: "/journal/notes", class: "py-2 rounded border text-gray-600 hover:bg-gray-100") { text "Cancel" }
          input(type: "submit", value: "Save", class: "px-4 py-2 rounded bg-black text-white hover:bg-gray-800 cursor-pointer")
        end
      end
    end
  end
end
