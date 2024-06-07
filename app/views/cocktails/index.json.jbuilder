# frozen_string_literal: true

json.array! @cocktails, partial: 'cocktails/cocktail', as: :cocktail
