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

ActiveRecord::Schema.define(version: 2019_05_21_093654) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer "tracked"
    t.string "hubstaff_id"
    t.bigint "project_id"
    t.bigint "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_activities_on_project_id"
    t.index ["task_id"], name: "index_activities_on_task_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "azure_id"
    t.string "hubstaff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "azure_email"
  end

  create_table "members_organizations", id: false, force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "member_id", null: false
    t.index ["member_id", "organization_id"], name: "index_members_organizations_on_member_id_and_organization_id"
    t.index ["organization_id", "member_id"], name: "index_members_organizations_on_organization_id_and_member_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "azure_id"
    t.string "hubstaff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "azure_access_token"
    t.string "hubstaff_start_auth_code"
    t.string "hubstaff_access_token"
    t.datetime "hubstaff_token_get_at"
    t.string "hubstaff_refresh_token"
    t.datetime "hubstaff_token_will_end"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "organization_id"
    t.string "azure_id"
    t.string "azure_name"
    t.string "hubstaff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_projects_on_organization_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.string "azure_id"
    t.string "hubstaff_id"
    t.bigint "member_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hubstaff_lock_version"
    t.index ["member_id"], name: "index_tasks_on_member_id"
    t.index ["project_id"], name: "index_tasks_on_project_id"
  end

  add_foreign_key "projects", "organizations"
  add_foreign_key "tasks", "members"
  add_foreign_key "tasks", "projects"
end
