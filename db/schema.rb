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

ActiveRecord::Schema.define(version: 20160525010747) do

  create_table "candidates", force: :cascade do |t|
    t.string   "name"
    t.decimal  "probability", default: "0.0"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "mean_samples", force: :cascade do |t|
    t.integer  "candidate_id"
    t.date     "sample_date"
    t.decimal  "probability"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["candidate_id"], name: "index_mean_samples_on_candidate_id"
  end

  create_table "samples", force: :cascade do |t|
    t.integer  "source_id"
    t.integer  "candidate_id"
    t.decimal  "probability"
    t.datetime "time_added"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["candidate_id"], name: "index_samples_on_candidate_id"
    t.index ["source_id"], name: "index_samples_on_source_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tweets", force: :cascade do |t|
    t.string   "identity"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
