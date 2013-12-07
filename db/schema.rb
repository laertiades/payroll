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

ActiveRecord::Schema.define(version: 20131204231540) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "checks", force: true do |t|
    t.decimal  "hours"
    t.decimal  "rate",       precision: 8, scale: 2
    t.decimal  "gross",      precision: 8, scale: 2
    t.decimal  "fedtax",     precision: 8, scale: 2
    t.decimal  "soctax",     precision: 8, scale: 2
    t.decimal  "medtax",     precision: 8, scale: 2
    t.decimal  "emsoctax",   precision: 8, scale: 2
    t.decimal  "emmedtax",   precision: 8, scale: 2
    t.decimal  "net",        precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "worker_id"
  end

  create_table "workers", force: true do |t|
    t.string   "fname"
    t.string   "mname"
    t.string   "lname"
    t.text     "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.integer  "withhold"
    t.boolean  "married"
    t.decimal  "hourrate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
