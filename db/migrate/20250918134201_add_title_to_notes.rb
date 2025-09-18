class AddTitleToNotes < ActiveRecord::Migration[8.0]
  def change
    add_column :notes, :title, :string
  end
end
