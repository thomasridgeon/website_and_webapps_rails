class Journal::EditNote < Journal::BaseWidget
  needs :note, :plaintext, :controller

  def content
    page("Edit Note") do
      h2(class: "text-2xl font-bold mb-4 text-black text-center") { text "Edit Note" }

      form(action: "/journal/notes/#{@note.id}", method: "post", class: "space-y-4") do
        input(type: "hidden", name: "authenticity_token", value: @controller.send(:form_authenticity_token))
        # Rails style PATCH via hidden _method
        # HTML forms only support GET and POST methods natively.
        # Rails uses the _method hidden input to simulate other HTTP verbs like PATCH, PUT, or DELETE.
        # When the form is submitted as POST with _method=patch, Rails interprets it as a PATCH request, which matches your NotesController#update route.
        input(type: "hidden", name: "_method", value: "patch")
        textarea(name: "body", rows: 12, class: "w-full border rounded p-3 focus:outline-none focus:ring-2 focus:ring-blue-400") do
          text @plaintext
        end
        div(class: "flex justify-end space-x-4") do
          a(href: "/journal/notes/#{@note.id}", class: "px-4 py-2 rounded border text-gray-600 hover:bg-gray-100") { text "Cancel" }
          input(type: "submit", value: "update", class: "px-4 py-2 rounded bg-black text-white hover:bg-gray-800 cursor-pointer")
        end
      end
    end
  end
end
