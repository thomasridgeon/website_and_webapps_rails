class Journal::NotesController < ApplicationController
  before_action :require_user # checks if someone is logged in
  before_action :set_note, only: [ :show, :edit, :update, :destroy ] # before running the show, edit or update actions, Rails will call the set_note method which looks up the note in the database by params[:id]

  # GET /journal/notes
  def index
    @notes = current_user.notes
    render html: Journal::Notes.new(notes: @notes, controller: self).to_html.html_safe
  end

  # GET /journal/notes/:id
  def show
    key = Base64.decode64(session[:derived_key])
    @plaintext = @note.decrypt(key)
    render html: Journal::Note.new(plaintext: @plaintext, note_id: @note.id, controller: self).to_html.html_safe
  end

  # GET /journal/notes/new
  def new
    render html: Journal::NewNote.new(controller: self).to_html.html_safe
  end

  # POST /journal/notes
  def create
    key = Base64.decode64(session[:derived_key])
    # .decode64 because when I need to use the key for encrypting the note, I have to convert the key from the base64 encoded string it is stored as in the session, back into the raw binary so OpenSSL can use it.
    encrypted_note = Note.encrypt(params[:body], key) # params of what to encrypt is the plaintext body of the note, using the AES key decoded from the session
    note = current_user.notes.new(
      title: params[:title],
      ciphertext: encrypted_note.ciphertext,
      iv: encrypted_note.iv,
      tag: encrypted_note.tag
    )
    note.save
    redirect_to "/journal/notes/#{note.id}"
  end

  # GET /journal/notes/:id/edit
  def edit
    key = Base64.decode64(session[:derived_key])
    @plaintext = @note.decrypt(key)
    render html: Journal::EditNote.new(note: @note, plaintext: @plaintext, controller: self).to_html.html_safe
  end

  # PATCH/PUT /journal/notes/:id
  def update
    key = Base64.decode64(session[:derived_key])
    encrypted_note = Note.encrypt(params[:body], key)
    @note.update(
      title: params[:title],
      ciphertext: encrypted_note.ciphertext, # takes the existing note which Rails loads in the before_action set_note
      iv: encrypted_note.iv, # updates the database record by replacing the old ciphertext, IV and tag with newly encrypted values
      tag: encrypted_note.tag
    )
    redirect_to "/journal/notes/#{@note.id}" # after updating, redirect the user to the show page for that note (GET /journal/notes/:id)
  end

  def destroy
    @note.destroy
    redirect_to "/journal/notes", notice: "Note was successfully deleted."
  end

  private

  def require_user
    redirect_to "/journal/login" unless current_user
  end

  def set_note
    @note = current_user.notes.find(params[:id])
  end

  def note_params
    params.permit(:title)
  end
end
