class CreateThings < ActiveRecord::Migration[7.1]
  def change
    create_table :things do |t|
      t.string :name
      t.references :cocktail_ingredient, null: false, foreign_key: false

      t.timestamps
    end
  end
end
