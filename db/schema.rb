# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_10_025246) do

  create_table "taggings", force: :cascade do |t|
    t.integer "taggable_id", null: false
    t.string "taggable_type", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "tag_id"], name: "index_taggings_on_taggable_id_and_taggable_type_and_tag_id", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "title", limit: 100, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_tags_on_title", unique: true
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title", limit: 500, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "taggings", "tags"
end
