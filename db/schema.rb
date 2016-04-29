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

ActiveRecord::Schema.define(version: 20160429173842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.string   "olid"
    t.text     "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["olid"], name: "index_authors_on_olid", unique: true, using: :btree
  end

  create_table "authorships", force: :cascade do |t|
    t.integer  "author_id"
    t.integer  "title_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_authorships_on_author_id", using: :btree
    t.index ["title_id"], name: "index_authorships_on_title_id", using: :btree
  end

  create_table "books", force: :cascade do |t|
    t.integer  "title_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title_id"], name: "index_books_on_title_id", using: :btree
  end

  create_table "section_assignments", force: :cascade do |t|
    t.integer  "title_id"
    t.integer  "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_section_assignments_on_section_id", using: :btree
    t.index ["title_id"], name: "index_section_assignments_on_title_id", using: :btree
  end

  create_table "sections", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "titles", force: :cascade do |t|
    t.string   "title"
    t.string   "olid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["olid"], name: "index_titles_on_olid", unique: true, using: :btree
  end

  add_foreign_key "authorships", "authors"
  add_foreign_key "authorships", "titles"
  add_foreign_key "books", "titles"
  add_foreign_key "section_assignments", "sections"
  add_foreign_key "section_assignments", "titles"
end
