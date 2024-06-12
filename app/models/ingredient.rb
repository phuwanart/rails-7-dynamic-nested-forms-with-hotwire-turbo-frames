# frozen_string_literal: true

class Ingredient < ApplicationRecord
  has_many :cocktail_ingredients, dependent: :destroy
  has_many :cocktails, through: :cocktail_ingredients

  def self.ransortable_attributes(_auth_object = nil)
    column_names
  end

  def self.ransackable_attributes(_auth_object = nil)
    ransortable_attributes + _ransackers.keys
  end
end
