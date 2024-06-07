# frozen_string_literal: true

class CreateCocktailIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :cocktail_ingredients do |t|
      t.belongs_to :cocktail, null: false, foreign_key: true
      t.belongs_to :ingredient, null: false, foreign_key: true
      t.string :quantity

      t.timestamps
    end
  end
end
