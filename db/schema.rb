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

ActiveRecord::Schema.define(version: 20170613203617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "app_monitors", force: :cascade do |t|
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "api_key", null: false
    t.index ["account_id"], name: "index_app_monitors_on_account_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.bigint "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "task_instances", force: :cascade do |t|
    t.bigint "task_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_task_instances_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "app_monitor_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_monitor_id"], name: "index_tasks_on_app_monitor_id"
    t.index ["name"], name: "index_tasks_on_name"
  end

  create_table "user_account_accesses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "account_id"
    t.integer "access_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_user_account_accesses_on_account_id"
    t.index ["user_id"], name: "index_user_account_accesses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "app_monitors", "accounts"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "task_instances", "tasks", on_delete: :cascade
  add_foreign_key "tasks", "app_monitors", on_delete: :cascade
  add_foreign_key "user_account_accesses", "accounts"
  add_foreign_key "user_account_accesses", "users"
end
