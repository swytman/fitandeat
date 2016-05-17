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

ActiveRecord::Schema.define(version: 20160517153652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "day_exercises", force: :cascade do |t|
    t.integer  "program_day_id"
    t.integer  "exercise_id"
    t.integer  "count",          default: 0
    t.integer  "order"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "description",    default: ""
  end

  create_table "equipment", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
  end

  create_table "equipment_exercises", id: false, force: :cascade do |t|
    t.integer "equipment_id", null: false
    t.integer "exercise_id",  null: false
  end

  create_table "exercise_steps", force: :cascade do |t|
    t.string   "title"
    t.integer  "exercise_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "exercises", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "unit_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "key"
    t.string "title"
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.integer "user_id",  null: false
    t.integer "group_id", null: false
  end

  create_table "program_days", force: :cascade do |t|
    t.integer  "program_id"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "programs", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "cycle",       default: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "telegram_id"
    t.integer "program_id"
    t.integer "missed_days", default: 0
    t.date    "start_date"
  end

  create_table "units", force: :cascade do |t|
    t.string   "short_title"
    t.string   "title"
    t.string   "few_title"
    t.string   "many_title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer "telegram_id"
    t.integer "telegram_name"
  end

end
