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

ActiveRecord::Schema.define(version: 20151026090609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accomodation_waves", force: :cascade do |t|
    t.integer  "duration"
    t.integer  "alternative_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "budget"
    t.text     "advertising_tools"
  end

  create_table "advertising_tools", force: :cascade do |t|
    t.string   "platform_title"
    t.string   "tool_title"
    t.string   "showing_place"
    t.string   "price_model"
    t.float    "period_cost"
    t.integer  "period"
    t.integer  "max_interval"
    t.float    "average_show"
    t.float    "ctr"
    t.float    "click_cost"
    t.integer  "period_quantity", default: 0
    t.integer  "result",          default: 0
    t.integer  "alternative_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "alternatives", force: :cascade do |t|
    t.integer  "segment_id"
    t.integer  "replication_model_id"
    t.text     "parameter1",                        default: "---\n- 0\n- 0\n- 0\n"
    t.text     "parameter2",                        default: "---\n- 0\n- 0\n- 0\n"
    t.text     "parameter3",                        default: "---\n- 0\n- 0\n- 0\n"
    t.text     "parameter4",                        default: "---\n- 0\n- 0\n- 0\n"
    t.text     "parameter5",                        default: "---\n- 0\n- 0\n- 0\n"
    t.text     "parameter6",                        default: "---\n- 0\n- 0\n- 0\n"
    t.text     "parameter7",                        default: "---\n- 0\n- 0\n- 0\n"
    t.text     "parameter8",                        default: "---\n- 0\n- 0\n- 0\n"
    t.text     "parameter9",                        default: "---\n- 0\n- 0\n- 0\n"
    t.text     "parameter10",                       default: "---\n- 0\n- 0\n- 0\n"
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
    t.float    "average_cost",                      default: 0.0
    t.integer  "pessimistic_profit",                default: 0
    t.integer  "real_profit",                       default: 0
    t.integer  "optimistic_profit",                 default: 0
    t.boolean  "step1"
    t.boolean  "step2"
    t.boolean  "step3"
    t.boolean  "step4"
    t.string   "advertising_tool_csv_file_name"
    t.string   "advertising_tool_csv_content_type"
    t.integer  "advertising_tool_csv_file_size"
    t.datetime "advertising_tool_csv_updated_at"
  end

  create_table "grouping_parameters", force: :cascade do |t|
    t.string   "grouping_field"
    t.string   "kind"
    t.integer  "grouping_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "groupings", force: :cascade do |t|
    t.string   "title"
    t.integer  "software_product_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "item_segments", force: :cascade do |t|
    t.integer  "research_item_id"
    t.integer  "segment_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "parameter_weights", force: :cascade do |t|
    t.float    "parameter1",  default: 0.0
    t.float    "parameter2",  default: 0.0
    t.float    "parameter3",  default: 0.0
    t.float    "parameter4",  default: 0.0
    t.float    "parameter5",  default: 0.0
    t.float    "parameter6",  default: 0.0
    t.float    "parameter7",  default: 0.0
    t.float    "parameter8",  default: 0.0
    t.float    "parameter9",  default: 0.0
    t.float    "parameter10", default: 0.0
    t.integer  "grouping_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "quality_grouping_values", force: :cascade do |t|
    t.string   "title"
    t.text     "values"
    t.integer  "grouping_parameter_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "quantity_grouping_values", force: :cascade do |t|
    t.string   "title"
    t.integer  "max_count"
    t.integer  "min_count"
    t.integer  "grouping_parameter_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "replication_models", force: :cascade do |t|
    t.string   "title"
    t.float    "fixed_costs"
    t.float    "variable_costs"
    t.integer  "software_product_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "investition_percent"
  end

  create_table "research_items", force: :cascade do |t|
    t.text     "data"
    t.integer  "software_product_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "segments", force: :cascade do |t|
    t.string   "title"
    t.integer  "grouping_value_id"
    t.string   "grouping_value_type"
    t.integer  "grouping_id"
    t.string   "ancestry"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "software_products", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "research_items_csv_file_name"
    t.string   "research_items_csv_content_type"
    t.integer  "research_items_csv_file_size"
    t.datetime "research_items_csv_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "workforce_directories", force: :cascade do |t|
    t.string   "specialists"
    t.integer  "available_resources"
    t.integer  "software_product_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "workforces", force: :cascade do |t|
    t.string   "specialists"
    t.integer  "fixed_resources"
    t.integer  "variable_resources"
    t.integer  "replication_model_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
