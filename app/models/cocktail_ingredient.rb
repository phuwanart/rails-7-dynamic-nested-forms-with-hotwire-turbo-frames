# frozen_string_literal: true

class CocktailIngredient < ApplicationRecord
  belongs_to :cocktail
  belongs_to :ingredient
end
