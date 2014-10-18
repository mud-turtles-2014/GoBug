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

ActiveRecord::Schema.define(version: 20141018134647) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", force: true do |t|
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expenses", force: true do |t|
    t.integer  "location_id", null: false
    t.float    "cost",        null: false
    t.string   "title"
    t.text     "description", null: false
    t.integer  "category_id", null: false
    t.date     "date"
    t.integer  "trip_id",     null: false
    t.integer  "currency_id"
    t.float    "usd_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "expenses", ["category_id"], name: "index_expenses_on_category_id", using: :btree
  add_index "expenses", ["location_id"], name: "index_expenses_on_location_id", using: :btree
  add_index "expenses", ["trip_id"], name: "index_expenses_on_trip_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trips", force: true do |t|
    t.integer  "user_id",                      null: false
    t.string   "name",                         null: false
    t.text     "description",                  null: false
    t.integer  "budget",                       null: false
    t.boolean  "is_published", default: false
    t.boolean  "is_private",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trips", ["user_id"], name: "index_trips_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.string   "email",           null: false
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wishlist_items", force: true do |t|
    t.integer  "item_id"
    t.integer  "wishlist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wishlists", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.float    "budget"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
