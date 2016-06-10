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

ActiveRecord::Schema.define(version: 20160610164929) do

  create_table "photos", force: :cascade do |t|
    t.integer  "order"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "url"
    t.string   "string"
    t.integer  "result_product_id"
    t.integer  "search_id"
  end

  add_index "photos", ["result_product_id"], name: "index_photos_on_result_product_id"
  add_index "photos", ["search_id"], name: "index_photos_on_search_id"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.string   "url"
    t.integer  "sold"
    t.string   "description_html"
    t.boolean  "is_new"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "source"
  end

  create_table "products_searches", id: false, force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "search_id",  null: false
  end

  create_table "result_products", force: :cascade do |t|
    t.string   "name"
    t.string   "nick_seller"
    t.integer  "price"
    t.string   "url"
    t.integer  "sold"
    t.string   "description_html"
    t.boolean  "is_new"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "search_id"
    t.string   "source"
    t.string   "source_id"
    t.string   "currency"
  end

  create_table "searches", force: :cascade do |t|
    t.string   "name"
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "source_configs", force: :cascade do |t|
    t.string   "datasource"
    t.string   "login"
    t.string   "password"
    t.string   "domain"
    t.boolean  "active"
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
