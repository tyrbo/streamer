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

ActiveRecord::Schema.define(version: 20141013195519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contestants", force: true do |t|
    t.string  "name"
    t.string  "logo"
    t.string  "acronym"
    t.integer "wins"
    t.integer "losses"
    t.integer "team_id"
  end

  create_table "games", force: true do |t|
    t.boolean  "live",       default: false
    t.string   "match_name"
    t.integer  "winner_id"
    t.integer  "match_id"
    t.integer  "league_id"
    t.integer  "max_games"
    t.boolean  "finished"
    t.datetime "date_time"
  end

  add_index "games", ["date_time"], name: "index_games_on_date_time", using: :btree
  add_index "games", ["league_id"], name: "index_games_on_league_id", using: :btree
  add_index "games", ["match_id"], name: "index_games_on_match_id", using: :btree

  create_table "matches", force: true do |t|
    t.integer "game_id"
    t.integer "contestant_id"
  end

  create_table "users", force: true do |t|
    t.string "display_name"
    t.string "name"
    t.string "email"
    t.string "bio"
    t.string "logo"
    t.string "type"
  end

end
