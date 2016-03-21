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

ActiveRecord::Schema.define(version: 20160321062952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string   "title"
    t.string   "fname"
    t.string   "mname"
    t.string   "lname"
    t.string   "suffix"
    t.string   "full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors_books", force: :cascade do |t|
    t.integer "author_id"
    t.integer "book_id"
  end

  add_index "authors_books", ["author_id"], name: "index_authors_books_on_author_id", using: :btree
  add_index "authors_books", ["book_id"], name: "index_authors_books_on_book_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "isbn"
    t.string   "title"
    t.string   "cover"
    t.string   "publisher"
    t.integer  "pages"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "isbn10"
  end

  add_index "books", ["isbn"], name: "index_books_on_isbn", unique: true, using: :btree
  add_index "books", ["title"], name: "index_books_on_title", using: :btree

  create_table "borrowers", force: :cascade do |t|
    t.string   "card_no"
    t.string   "ssn"
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.text     "address"
    t.string   "city"
    t.string   "state"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "borrowers", ["card_no"], name: "index_borrowers_on_card_no", unique: true, using: :btree
  add_index "borrowers", ["ssn"], name: "index_borrowers_on_ssn", unique: true, using: :btree

  create_table "branches", force: :cascade do |t|
    t.string   "name"
    t.text     "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "copies", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "branch_id"
    t.integer  "no_of_copies"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "copies", ["book_id"], name: "index_copies_on_book_id", using: :btree
  add_index "copies", ["branch_id"], name: "index_copies_on_branch_id", using: :btree

  create_table "loans", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "branch_id"
    t.integer  "borrower_id"
    t.date     "date_out"
    t.date     "date_in"
    t.date     "due_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "loans", ["book_id"], name: "index_loans_on_book_id", using: :btree
  add_index "loans", ["borrower_id"], name: "index_loans_on_borrower_id", using: :btree
  add_index "loans", ["branch_id"], name: "index_loans_on_branch_id", using: :btree

  add_foreign_key "authors_books", "authors"
  add_foreign_key "authors_books", "books"
  add_foreign_key "copies", "books"
  add_foreign_key "copies", "branches"
  add_foreign_key "loans", "books"
  add_foreign_key "loans", "borrowers"
  add_foreign_key "loans", "branches"
end
