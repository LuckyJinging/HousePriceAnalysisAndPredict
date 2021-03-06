# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_08_054056) do

  create_table "articles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "book", primary_key: "book_id", id: :string, limit: 20, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin", force: :cascade do |t|
    t.string "book_name", limit: 50, null: false
    t.integer "publisher_id"
    t.integer "type_id"
    t.string "book_info", limit: 200
    t.string "author", limit: 50
    t.timestamp "pub_timr"
    t.integer "book_num"
  end

  create_table "booktests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "operation", primary_key: "operation_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin", force: :cascade do |t|
    t.string "operation_name", limit: 20, null: false
  end

  create_table "publisher", primary_key: "publisher_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin", force: :cascade do |t|
    t.string "publisher_name", limit: 50, null: false
  end

  create_table "records", primary_key: "record_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin", force: :cascade do |t|
    t.string "book_id", limit: 20, null: false
    t.integer "operation_id", null: false
    t.integer "operation_count", null: false
    t.timestamp "operation_time"
  end

  create_table "type", primary_key: "type_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin", force: :cascade do |t|
    t.string "type_name", limit: 20, null: false
  end

end
