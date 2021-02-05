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

ActiveRecord::Schema.define(version: 2021_02_01_133329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "uuid-ossp"

  create_table "apparatus", force: :cascade do |t|
    t.uuid "guid", default: -> { "uuid_generate_v4()" }
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_apparatus_on_deleted_at"
    t.index ["guid"], name: "index_apparatus_on_guid", unique: true
  end

  create_table "hydrant_checks", force: :cascade do |t|
    t.uuid "guid", default: -> { "uuid_generate_v4()" }
    t.bigint "hydrant_id", null: false
    t.bigint "pump_operator_id", null: false
    t.bigint "apparatus_id", null: false
    t.boolean "needs_follow_up", default: false, null: false
    t.boolean "vegetation_overgrown", default: false, null: false
    t.boolean "tank_locked", default: true, null: false
    t.boolean "lock_operable", default: true, null: false
    t.boolean "prime_pulled", default: true, null: false
    t.boolean "circulated", default: true, null: false
    t.integer "line_used"
    t.integer "minutes_pumped"
    t.boolean "in_service", default: true, null: false
    t.text "notes"
    t.datetime "approved_at"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["apparatus_id"], name: "index_hydrant_checks_on_apparatus_id"
    t.index ["deleted_at"], name: "index_hydrant_checks_on_deleted_at"
    t.index ["guid"], name: "index_hydrant_checks_on_guid", unique: true
    t.index ["hydrant_id"], name: "index_hydrant_checks_on_hydrant_id"
    t.index ["pump_operator_id"], name: "index_hydrant_checks_on_pump_operator_id"
  end

  create_table "hydrants", force: :cascade do |t|
    t.uuid "guid", default: -> { "uuid_generate_v4()" }
    t.string "name"
    t.geography "coordinates", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.integer "hydrant_type", default: 0, null: false
    t.text "staff_notes"
    t.datetime "last_tested_at"
    t.boolean "in_service", default: true, null: false
    t.datetime "needs_follow_up"
    t.text "last_check_note"
    t.string "tank_capacity"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_hydrants_on_deleted_at"
    t.index ["guid"], name: "index_hydrants_on_guid", unique: true
  end

  create_table "pump_operators", force: :cascade do |t|
    t.uuid "guid", default: -> { "uuid_generate_v4()" }
    t.string "name"
    t.string "email_address"
    t.string "phone_number"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_pump_operators_on_deleted_at"
    t.index ["guid"], name: "index_pump_operators_on_guid", unique: true
  end

end
