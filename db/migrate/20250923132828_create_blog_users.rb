class CreateBlogUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :blog_users do |t|
      t.string :username
      t.string :password_digest
      t.boolean :admin, default: false, null: false
      t.timestamps
    end
  end
end
