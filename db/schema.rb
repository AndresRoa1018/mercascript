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

ActiveRecord::Schema.define(version: 20160616171253) do

  create_table "photos", force: :cascade do |t|
    t.integer  "order",               limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "url",                 limit: 255
    t.integer  "result_product_id",   limit: 4
    t.integer  "search_id",           limit: 4
    t.string   "name_file_name",      limit: 255
    t.string   "name_content_type",   limit: 255
    t.integer  "name_file_size",      limit: 4
    t.datetime "name_updated_at"
    t.string   "string_file_name",    limit: 255
    t.string   "string_content_type", limit: 255
    t.integer  "string_file_size",    limit: 4
    t.datetime "string_updated_at"
  end

  add_index "photos", ["result_product_id"], name: "index_photos_on_result_product_id", using: :btree
  add_index "photos", ["search_id"], name: "index_photos_on_search_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.integer  "price",            limit: 4
    t.string   "url",              limit: 255
    t.string   "description_html", limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "source",           limit: 255
  end

  create_table "products_searches", id: false, force: :cascade do |t|
    t.integer "product_id", limit: 4, null: false
    t.integer "search_id",  limit: 4, null: false
  end

# Could not dump table "result_products" because of following StandardError
#   Unknown type 'json' for column 'data'

  create_table "searches", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "data",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "source_configs", force: :cascade do |t|
    t.string   "datasource", limit: 255
    t.string   "login",      limit: 255
    t.string   "password",   limit: 255
    t.string   "domain",     limit: 255
    t.boolean  "active"
    t.text     "data",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
