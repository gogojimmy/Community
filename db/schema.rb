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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121203070333) do

  create_table "accounts", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "balance",    :default => 0
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "accounts", ["created_by"], :name => "index_accounts_on_created_by"
  add_index "accounts", ["name"], :name => "index_accounts_on_name"
  add_index "accounts", ["updated_by"], :name => "index_accounts_on_updated_by"

  create_table "buildings", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  add_index "buildings", ["created_by"], :name => "index_buildings_on_created_by"
  add_index "buildings", ["updated_by"], :name => "index_buildings_on_updated_by"

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body"
    t.string   "subject",          :default => ""
    t.integer  "user_id",          :default => 0,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "payments", :force => true do |t|
    t.integer  "management_fee"
    t.integer  "car_fee"
    t.integer  "bike_fee"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "paid_date"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "resident_id"
  end

  add_index "payments", ["created_by"], :name => "index_payments_on_created_by"
  add_index "payments", ["resident_id"], :name => "index_payments_on_resident_id"
  add_index "payments", ["updated_by"], :name => "index_payments_on_updated_by"

  create_table "residents", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "car_num"
    t.string   "bike_num"
    t.boolean  "rent"
    t.string   "pid"
    t.integer  "unit_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "residents", ["bike_num"], :name => "index_residents_on_bike_num"
  add_index "residents", ["car_num"], :name => "index_residents_on_car_num"
  add_index "residents", ["created_by"], :name => "index_residents_on_created_by"
  add_index "residents", ["name"], :name => "index_residents_on_name"
  add_index "residents", ["phone"], :name => "index_residents_on_phone"
  add_index "residents", ["pid"], :name => "index_residents_on_pid"
  add_index "residents", ["unit_id"], :name => "index_residents_on_unit_id"
  add_index "residents", ["updated_by"], :name => "index_residents_on_updated_by"

  create_table "transaction_types", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.string   "self_type"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "transaction_types", ["created_by"], :name => "index_transaction_types_on_created_by"
  add_index "transaction_types", ["updated_by"], :name => "index_transaction_types_on_updated_by"

  create_table "transactions", :force => true do |t|
    t.integer  "from_account_id"
    t.integer  "to_account_id"
    t.integer  "transaction_type_id"
    t.integer  "amount"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.text     "description"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "transactions", ["created_by"], :name => "index_transactions_on_created_by"
  add_index "transactions", ["from_account_id"], :name => "index_transactions_on_from_account_id"
  add_index "transactions", ["to_account_id"], :name => "index_transactions_on_to_account_id"
  add_index "transactions", ["transaction_type_id"], :name => "index_transactions_on_transaction_type_id"
  add_index "transactions", ["updated_by"], :name => "index_transactions_on_updated_by"

  create_table "units", :force => true do |t|
    t.integer  "building_id"
    t.string   "num"
    t.string   "address"
    t.float    "pin"
    t.integer  "management_fee"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  add_index "units", ["building_id"], :name => "index_units_on_building_id"
  add_index "units", ["created_by"], :name => "index_units_on_created_by"
  add_index "units", ["updated_by"], :name => "index_units_on_updated_by"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "resident@resident.com", :null => false
    t.string   "encrypted_password",     :default => "",                      :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "phone"
    t.string   "pid"
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["phone"], :name => "index_users_on_phone"
  add_index "users", ["pid"], :name => "index_users_on_pid"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
