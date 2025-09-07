class Journal::NotesController < ApplicationController
  
  before_action :require_user # checks if someone is logged in
  before_action :set_note, only [:show, :edit, :update] # before running the show, edit or update actions, Rails will call the set_note method which looks up the note in the database by params[:id]

  # GET /journal/notes
  def index
    @notes = current_user.notes
    render html: Notes.new(@notes).to_html.html_safe
  end

  # GET /journal/notes/:id
  def show
    key = Base64.decode64(session[:derived_key])
    @plaintext = note.decrypt(key)
    render html: Note.new(@plaintext).to_html.html_safe
  end

  # GET /journal/notes/new
  def new
    render html: NewNote.new.to_html.html_safe
  end

  #POST /journal/notes
  def create
    key = Base64.decode64(session[:derived_key]) 
    # .decode64 because when I need to use the key for encrypting the note, I have to convert the key from the base64 encoded string it is stored as in the session, back into the raw binary so OpenSSL can use it.
    note = Note.encrypt(params[:body], key) # params of what to encrypt is the plaintext body of the note, using the AES key decoded from the session
    note.user = current_user
    note.save
    redirect journal_note_path(note)
  end

  # GET /journal/notes/:id/edit
  def edit
    render html: EditNote.new(@note).to_html.html_safe
  end

  # PATCH/PUT /journal/notes/:id
  def update
    key = Base64.decode64(session[:derived_key])
    encrypted_note = Note.encrypt(params[:body]. key)
    @note.update(
      ciphertext: encrypted_note.ciphertext, # takes the existing note which Rails loads in the before_action set_note
      iv: encrypted_note.iv, # updates the database record by replacing the old ciphertext, IV and tag with newly encrypted values
      tag: encrypted_note.tag
    )
    redirect journal_note_path(@note) # after updating, redirect the user to the show page for that note (GET /journal/notes/:id)
  end
  
  def destroy
    @note.destroy
    redirect journal_notes_path, notice: "Note was successfully deleted."
  end

  private 

  def require_user
    redirect_to journal_login_path unless current_user
  end

  def set_note
    @note = current_user.notes.find(params[:id])
  end
end
