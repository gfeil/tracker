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

ActiveRecord::Schema.define(version: 20160320215352) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "visitors", force: :cascade do |t|
    t.string   "visit_key"
    t.date     "starts_on"
    t.date     "ends_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "visitors", ["starts_on", "ends_on"], name: "index_visitors_on_starts_on_and_ends_on", using: :btree
  add_index "visitors", ["visit_key", "ends_on"], name: "index_visitors_on_visit_key_and_ends_on", using: :btree

end
