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

ActiveRecord::Schema.define(version: 20151214301045) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conclusion_types", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "data_types", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "data_types", ["name"], name: "dt_table_constraints", unique: true, using: :btree

  create_table "expenses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",            null: false
    t.integer  "expense_type_id"
    t.integer  "amount"
    t.string   "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "expenses", ["user_id"], name: "index_expenses_on_user_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "object_attributes", force: :cascade do |t|
    t.integer  "object_type_id"
    t.integer  "data_type_id"
    t.string   "name",           null: false
    t.string   "description",    null: false
    t.json     "conditions",     null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "object_attributes", ["data_type_id"], name: "index_object_attributes_on_data_type_id", using: :btree
  add_index "object_attributes", ["object_type_id", "data_type_id", "name"], name: "oa_table_constraints", unique: true, using: :btree
  add_index "object_attributes", ["object_type_id"], name: "index_object_attributes_on_object_type_id", using: :btree

  create_table "object_types", force: :cascade do |t|
    t.string   "description"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "object_types", ["name"], name: "ot_table_constraints", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "rule_items", force: :cascade do |t|
    t.integer  "rule_id"
    t.string   "condition",      null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "object_type_id"
  end

  add_index "rule_items", ["rule_id"], name: "index_rule_items_on_rule_id", using: :btree

  create_table "rules", force: :cascade do |t|
    t.string   "name",               null: false
    t.string   "description"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "user_id"
    t.integer  "conclusion_type_id"
  end

  create_table "user_notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "notification_type_id"
    t.integer  "ref_id"
    t.integer  "rule_id"
    t.string   "description"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "approval_status_type_id", default: 0
    t.string   "reason"
  end

  add_index "user_notifications", ["user_id", "ref_id", "notification_type_id", "rule_id"], name: "un_table_constraints", unique: true, using: :btree
  add_index "user_notifications", ["user_id"], name: "index_user_notifications_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.integer  "user_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  add_foreign_key "expenses", "users"
  add_foreign_key "object_attributes", "data_types"
  add_foreign_key "object_attributes", "object_types"
  add_foreign_key "rule_items", "rules"
  add_foreign_key "rules", "conclusion_types"
  add_foreign_key "rules", "users"
  add_foreign_key "user_notifications", "users"
end
