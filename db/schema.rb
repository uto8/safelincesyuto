# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_05_28_151548) do

  create_table "drivers", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_drivers_on_project_id"
    t.index ["user_id"], name: "index_drivers_on_user_id"
  end

  create_table "license_users", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "license_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["license_id"], name: "index_license_users_on_license_id"
    t.index ["user_id", "license_id"], name: "index_license_users_on_user_id_and_license_id", unique: true
    t.index ["user_id"], name: "index_license_users_on_user_id"
  end

  create_table "licenses", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.integer "fee"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "project_licenses", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "license_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["license_id"], name: "index_project_licenses_on_license_id"
    t.index ["project_id"], name: "index_project_licenses_on_project_id"
  end

  create_table "project_users", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_users_on_project_id"
    t.index ["user_id"], name: "index_project_users_on_user_id"
  end

  create_table "projects", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.bigint "leader_id"
    t.boolean "is_registration"
    t.string "address"
    t.text "supplement"
    t.boolean "is_read"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["leader_id"], name: "index_projects_on_leader_id"
  end

  create_table "trips", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_trips_on_project_id"
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "user_allowances", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "license_id", null: false
    t.integer "price"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["license_id"], name: "index_user_allowances_on_license_id"
    t.index ["user_id"], name: "index_user_allowances_on_user_id"
  end

  create_table "user_registrations", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_user_registrations_on_project_id"
    t.index ["user_id"], name: "index_user_registrations_on_user_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.boolean "is_admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "drivers", "projects"
  add_foreign_key "drivers", "users"
  add_foreign_key "license_users", "licenses"
  add_foreign_key "license_users", "users"
  add_foreign_key "project_licenses", "licenses"
  add_foreign_key "project_licenses", "projects"
  add_foreign_key "project_users", "projects"
  add_foreign_key "project_users", "users"
  add_foreign_key "projects", "users", column: "leader_id"
  add_foreign_key "trips", "projects"
  add_foreign_key "trips", "users"
  add_foreign_key "user_allowances", "licenses"
  add_foreign_key "user_allowances", "users"
  add_foreign_key "user_registrations", "projects"
  add_foreign_key "user_registrations", "users"
end
