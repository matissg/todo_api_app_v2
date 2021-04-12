class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts, comment: 'List of posts' do |t|
      t.string :title, limit: 500, null: false, comment: 'Post title'
      t.text :content, limit: 5000, comment: 'Post content'

      t.timestamps
    end
  end
end
