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

ActiveRecord::Schema.define(version: 2020_05_12_165422) do

  create_table "fingerprints", force: :cascade do |t|
    t.string "width"
    t.string "height"
    t.string "depth"
    t.string "timezone"
    t.string "user_agent"
    t.string "accept_headers"
    t.string "accept_encoding"
    t.string "accept_language"
    t.boolean "cookies_enabled"
    t.text "serialized"
    t.text "plugins"
    t.text "fonts"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ga"
    t.integer "hits", default: 0
    t.datetime "last_visit"
  end

end
