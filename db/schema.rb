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

ActiveRecord::Schema.define(version: 20170503115056) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authentications", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "confirms", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.integer  "activity_id"
    t.datetime "time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "location"
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "schedule1_id"
    t.integer  "schedule2_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["schedule1_id"], name: "index_matches_on_schedule1_id", using: :btree
    t.index ["schedule2_id"], name: "index_matches_on_schedule2_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedule_responses", force: :cascade do |t|
    t.integer  "responder_id"
    t.integer  "receiver_id"
    t.integer  "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["responder_id", "receiver_id"], name: "index_schedule_responses_on_responder_id_and_receiver_id", unique: true, using: :btree
  end

  create_table "schedules", force: :cascade do |t|
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.datetime "time"
    t.integer  "activity_id"
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_activities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.integer  "ability"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id", "activity_id"], name: "index_user_activities_on_user_id_and_activity_id", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.integer  "age"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "weekly_activity_hours"
    t.string   "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
