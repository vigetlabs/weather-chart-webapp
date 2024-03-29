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

ActiveRecord::Schema.define(version: 20160920154446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data_points", force: :cascade do |t|
    t.integer  "data_type_id"
    t.datetime "value_timestamp"
    t.float    "value"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "zipcode"
  end

  add_index "data_points", ["data_type_id"], name: "index_data_points_on_data_type_id", using: :btree

  create_table "data_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "x_res"
    t.integer  "now"
    t.string   "position"
    t.string   "light"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "identifier"
  end

  create_table "settings", force: :cascade do |t|
    t.integer  "data_type_id"
    t.integer  "x_res"
    t.integer  "now"
    t.string   "position"
    t.string   "light"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "zipcode"
    t.integer  "location_key", default: 1
  end

  add_index "settings", ["data_type_id"], name: "index_settings_on_data_type_id", using: :btree

  add_foreign_key "data_points", "data_types"
  add_foreign_key "settings", "data_types"
end
