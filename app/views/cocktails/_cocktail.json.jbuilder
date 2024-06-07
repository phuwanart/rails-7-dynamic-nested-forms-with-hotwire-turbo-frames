# frozen_string_literal: true

json.extract! cocktail, :id, :name, :recipe, :created_at, :updated_at
json.url cocktail_url(cocktail, format: :json)
