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

ActiveRecord::Schema.define(:version => 20121127111357) do

  create_table "buildings", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "units", :force => true do |t|
    t.integer  "building_id"
    t.string   "num"
    t.string   "address"
    t.float    "pin"
    t.integer  "management_fee"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "units", ["building_id"], :name => "index_units_on_building_id"

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
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["phone"], :name => "index_users_on_phone"
  add_index "users", ["pid"], :name => "index_users_on_pid"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
