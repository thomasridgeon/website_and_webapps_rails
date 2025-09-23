class CreateBlogPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :body
      t.references :blog_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
