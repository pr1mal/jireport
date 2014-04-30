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

ActiveRecord::Schema.define(version: 20140430043412) do

  create_table "report_entries", force: true do |t|
    t.integer  "user_id"
    t.integer  "report_id"
    t.string   "project"
    t.string   "task_id"
    t.string   "task_desc"
    t.datetime "msproject_task_completion_date"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.integer  "percentage"
    t.datetime "eta"
    t.string   "status"
    t.text     "issues"
    t.text     "risk_mitigation_plans"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "report_entries", ["report_id"], name: "index_report_entries_on_report_id"
  add_index "report_entries", ["user_id"], name: "index_report_entries_on_user_id"

  create_table "reports", force: true do |t|
    t.datetime "generated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports_users", force: true do |t|
    t.integer  "report_id"
    t.integer  "user_id"
    t.string   "vac"
    t.boolean  "on_track"
    t.string   "delay_details"
    t.string   "recovery_plan"
    t.text     "comments"
    t.boolean  "user_report_ready"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reports_users", ["report_id"], name: "index_reports_users_on_report_id"
  add_index "reports_users", ["user_id"], name: "index_reports_users_on_user_id"

  create_table "users", force: true do |t|
    t.string   "full_name"
    t.string   "jira_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
