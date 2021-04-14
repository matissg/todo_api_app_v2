class CreateTaggings < ActiveRecord::Migration[6.0]
  def change
    create_table :taggings, comment: 'Tags linked to resource' do |t|
      t.bigint :taggable_id, null: false, foreign_key: true, comment: 'Taggable resource identificator'
      t.string :taggable_type, null: false, comment: 'Taggable resource class'

      t.references(
        :tag,
        type: :bigint,
        null: false,
        index: false,
        foreign_key: { to_table: :tags },
        comment: 'Tag identificator'
      )

      t.timestamps

      t.index %i[taggable_id taggable_type tag_id], unique: true
    end
  end
end
