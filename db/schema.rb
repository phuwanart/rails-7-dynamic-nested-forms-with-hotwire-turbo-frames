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

ActiveRecord::Schema[7.1].define(version: 2024_06_08_011155) do
  create_table "cocktail_ingredients", force: :cascade do |t|
    t.integer "cocktail_id", null: false
    t.integer "ingredient_id", null: false
    t.string "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cocktail_id"], name: "index_cocktail_ingredients_on_cocktail_id"
    t.index ["ingredient_id"], name: "index_cocktail_ingredients_on_ingredient_id"
  end

  create_table "cocktails", force: :cascade do |t|
    t.string "name"
    t.text "recipe"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "things", force: :cascade do |t|
    t.string "name"
    t.integer "cocktail_ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cocktail_ingredient_id"], name: "index_things_on_cocktail_ingredient_id"
  end

  add_foreign_key "cocktail_ingredients", "cocktails"
  add_foreign_key "cocktail_ingredients", "ingredients"
end
