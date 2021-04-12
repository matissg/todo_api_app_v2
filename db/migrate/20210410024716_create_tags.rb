class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags, comment: 'List of tags' do |t|
      t.string :title, limit: 100, null: false, index: { unique: true }, comment: 'Tag title'

      t.timestamps
    end
  end
end
