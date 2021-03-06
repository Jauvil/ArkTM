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

ActiveRecord::Schema.define(version: 20170724050307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dinos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "health"
    t.integer "stamina"
    t.integer "oxygen"
    t.integer "food"
    t.integer "weight"
    t.integer "melee"
    t.integer "movement_speed"
    t.integer "level"
    t.bigint "tribe_id"
    t.string "name"
    t.string "gender"
    t.string "breed"
    t.index ["tribe_id"], name: "index_dinos_on_tribe_id"
  end

  create_table "job_templates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tribe_id"
    t.string "name"
    t.text "description"
    t.index ["tribe_id"], name: "index_job_templates_on_tribe_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "job_template_id"
    t.index ["job_template_id"], name: "index_jobs_on_job_template_id"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "tribe_requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tribe_id"
    t.bigint "user_id"
    t.string "status", default: "active"
    t.index ["tribe_id"], name: "index_tribe_requests_on_tribe_id"
    t.index ["user_id"], name: "index_tribe_requests_on_user_id"
  end

  create_table "tribes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tribe_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["tribe_id"], name: "index_users_on_tribe_id"
  end

  add_foreign_key "dinos", "tribes"
  add_foreign_key "job_templates", "tribes"
  add_foreign_key "jobs", "job_templates"
  add_foreign_key "jobs", "users"
  add_foreign_key "tribe_requests", "tribes"
  add_foreign_key "tribe_requests", "users"
  add_foreign_key "users", "tribes"
end
