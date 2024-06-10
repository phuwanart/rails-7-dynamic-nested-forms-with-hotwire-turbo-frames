class Avo::Resources::CocktailIngredient < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :cocktail_id, as: :number
    field :ingredient_id, as: :number
    field :quantity, as: :text
    field :cocktail, as: :belongs_to
    field :ingredient, as: :belongs_to
    field :things, as: :has_many
  end
end
