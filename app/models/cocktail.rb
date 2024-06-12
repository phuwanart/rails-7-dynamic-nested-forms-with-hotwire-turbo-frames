# frozen_string_literal: true

class Cocktail < ApplicationRecord
  has_many :cocktail_ingredients, dependent: :destroy
  has_many :ingredients, through: :cocktail_ingredients
  accepts_nested_attributes_for :cocktail_ingredients, allow_destroy: true

  def self.ransortable_attributes(_auth_object = nil)
    column_names
  end

  def self.ransackable_attributes(_auth_object = nil)
    ransortable_attributes + _ransackers.keys
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[cocktail_ingredients ingredients]
  end
end
