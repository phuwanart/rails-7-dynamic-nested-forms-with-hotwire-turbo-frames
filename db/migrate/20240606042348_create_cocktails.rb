# frozen_string_literal: true

class CreateCocktails < ActiveRecord::Migration[7.1]
  def change
    create_table :cocktails do |t|
      t.string :name
      t.text :recipe

      t.timestamps
    end
  end
end
