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

ActiveRecord::Schema.define(version: 2019_12_05_073032) do

  create_table "coins", force: :cascade do |t|
    t.string "name", null: false
    t.string "symbol", null: false
    t.integer "scale", default: 8, null: false
  end

  create_table "price_sources", force: :cascade do |t|
    t.integer "price_coin_id", null: false
    t.string "name", null: false
    t.string "url", null: false
    t.string "last", null: false
    t.string "ask", null: false
    t.string "bid", null: false
    t.string "timestamp", null: false
    t.integer "coin_id"
    t.index ["coin_id"], name: "index_price_sources_on_coin_id"
  end

  create_table "prices", force: :cascade do |t|
    t.integer "coin_id", null: false
    t.decimal "last", precision: 32, scale: 16, null: false
    t.decimal "bid", precision: 32, scale: 16, null: false
    t.decimal "ask", precision: 32, scale: 16, null: false
    t.integer "price_source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["price_source_id"], name: "index_prices_on_price_source_id"
  end

end
