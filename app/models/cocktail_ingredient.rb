# frozen_string_literal: true

class CocktailIngredient < ApplicationRecord
  belongs_to :cocktail
  belongs_to :ingredient
  has_many :things, dependent: :destroy
  accepts_nested_attributes_for :things, allow_destroy: true
end
