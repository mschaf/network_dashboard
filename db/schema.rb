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

ActiveRecord::Schema.define(version: 2021_04_26_112115) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "address"
    t.string "type"
    t.boolean "reachable"
    t.bigint "host_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["host_id"], name: "index_addresses_on_host_id"
  end

  create_table "host_scans", force: :cascade do |t|
    t.string "target"
    t.boolean "up"
    t.datetime "scanned_at"
    t.string "state"
    t.jsonb "result", default: {}
    t.string "type"
    t.bigint "range_scan_id"
    t.bigint "address_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_id"], name: "index_host_scans_on_address_id"
    t.index ["range_scan_id"], name: "index_host_scans_on_range_scan_id"
  end

  create_table "hosts", force: :cascade do |t|
    t.string "mac"
    t.string "human_name"
    t.string "hostname"
    t.datetime "last_up"
    t.string "flags", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mac"], name: "index_hosts_on_mac", unique: true
  end

  create_table "range_scans", force: :cascade do |t|
    t.string "target_range"
    t.string "scan_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
