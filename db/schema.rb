# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_20_091329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "belongings", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "tournament_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_belongings_on_game_id"
    t.index ["tournament_id"], name: "index_belongings_on_tournament_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "player1_id"
    t.bigint "player2_id"
    t.bigint "tournament_id"
    t.bigint "game_id"
    t.string "winner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_matches_on_game_id"
    t.index ["player1_id"], name: "index_matches_on_player1_id"
    t.index ["player2_id"], name: "index_matches_on_player2_id"
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
  end

  create_table "participatings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "tournament_id"
    t.bigint "game_id"
    t.index ["game_id"], name: "index_participatings_on_game_id"
    t.index ["tournament_id"], name: "index_participatings_on_tournament_id"
    t.index ["user_id"], name: "index_participatings_on_user_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_players"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "facebook_id"
    t.string "role", default: "user"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "belongings", "games"
  add_foreign_key "belongings", "tournaments"
  add_foreign_key "matches", "games"
  add_foreign_key "matches", "tournaments"
  add_foreign_key "participatings", "games"
  add_foreign_key "participatings", "tournaments"
  add_foreign_key "participatings", "users"
end
