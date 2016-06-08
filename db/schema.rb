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

ActiveRecord::Schema.define(version: 20160410113307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "area_border_lines", force: :cascade do |t|
    t.float    "x_from"
    t.float    "y_from"
    t.float    "x_to"
    t.float    "y_to"
    t.integer  "area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "area_border_lines", ["area_id"], name: "index_area_border_lines_on_area_id", using: :btree

  create_table "areas", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "city_id"
  end

  add_index "areas", ["city_id"], name: "index_areas_on_city_id", using: :btree
  add_index "areas", ["user_id"], name: "index_areas_on_user_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["area_id"], name: "index_comments_on_area_id", using: :btree
  add_index "comments", ["user_id", "created_at"], name: "index_comments_on_user_id_and_created_at", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.text     "description"
    t.integer  "city_id"
    t.date     "birthday"
  end

  add_index "users", ["city_id"], name: "index_users_on_city_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "area_border_lines", "areas"
  add_foreign_key "areas", "cities"
  add_foreign_key "areas", "users"
  add_foreign_key "comments", "areas"
  add_foreign_key "comments", "users"
  add_foreign_key "users", "cities"
end
