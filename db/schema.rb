# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150816024447) do

  create_table "games", force: :cascade do |t|
    t.datetime "game_time"
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["away_team_id"], name: "index_games_on_away_team_id"
  add_index "games", ["home_team_id"], name: "index_games_on_home_team_id"

  create_table "picks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_id"
  end

  add_index "picks", ["game_id"], name: "index_picks_on_game_id"
  add_index "picks", ["team_id"], name: "index_picks_on_team_id"
  add_index "picks", ["user_id"], name: "index_picks_on_user_id"

  create_table "scores", force: :cascade do |t|
    t.integer  "home"
    t.integer  "away"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "city",       limit: 255
    t.string   "short",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "conference", limit: 255
    t.string   "division",   limit: 255
    t.string   "logo"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "displayname",            limit: 255
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
