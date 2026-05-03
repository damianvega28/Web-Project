# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_05_03_175513) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer "capacity", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.bigint "creator_id", null: false
    t.text "description"
    t.datetime "end_date", null: false
    t.datetime "start_date", null: false
    t.string "status", default: "draft"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.bigint "venue_id", null: false
    t.index ["category_id"], name: "index_events_on_category_id"
    t.index ["creator_id"], name: "index_events_on_creator_id"
    t.index ["venue_id"], name: "index_events_on_venue_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "venues", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "events", "categories"
  add_foreign_key "events", "users", column: "creator_id"
  add_foreign_key "events", "venues"
end
