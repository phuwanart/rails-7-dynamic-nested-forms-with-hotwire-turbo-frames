# frozen_string_literal: true

class FieldsController < ApplicationController
  # POST /fields/:model(/:id)/build/:association(/:partial)
  def build
    resource_class      = params[:model].classify.constantize                                     # => Cocktail
    association_class   = resource_class.reflect_on_association(params[:association]).klass       # => CocktailIngredient
    fields_partial_path = params[:partial] || "#{association_class.model_name.collection}/fields" # => "cocktail_ingredients/fields"
    render locals: { resource_class:, association_class:, fields_partial_path: }
  end
end
