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

ActiveRecord::Schema[8.0].define(version: 2025_10_22_060100) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "backlog_items", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_backlog_items_on_game_id"
    t.index ["user_id", "game_id"], name: "index_backlog_items_on_user_id_and_game_id", unique: true
    t.index ["user_id"], name: "index_backlog_items_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "igdb_id", null: false
    t.string "slug"
    t.text "summary"
    t.float "rating"
    t.string "cover_image_id"
    t.bigint "first_release_date"
    t.integer "platform_ids", default: [], null: false, array: true
    t.index ["igdb_id"], name: "index_games_on_igdb_id", unique: true
    t.index ["name"], name: "index_games_on_name"
    t.index ["platform_ids"], name: "index_games_on_platform_ids", using: :gin
    t.index ["slug"], name: "index_games_on_slug"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "backlog_items", "games"
  add_foreign_key "backlog_items", "users"
  add_foreign_key "sessions", "users"
end
