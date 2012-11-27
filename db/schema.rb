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

ActiveRecord::Schema.define(:version => 20121127220345) do

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
    t.integer  "user_id"
    t.datetime "paid_date"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "payments", ["created_by"], :name => "index_payments_on_created_by"
  add_index "payments", ["updated_by"], :name => "index_payments_on_updated_by"
  add_index "payments", ["user_id"], :name => "index_payments_on_user_id"

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
    t.string   "car_num"
    t.string   "bike_num"
    t.boolean  "rent"
    t.string   "pid"
    t.string   "role",                   :default => "resident"
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.integer  "unit_id"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  add_index "users", ["created_by"], :name => "index_users_on_created_by"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["phone"], :name => "index_users_on_phone"
  add_index "users", ["pid"], :name => "index_users_on_pid"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["updated_by"], :name => "index_users_on_updated_by"

end
