class Avo::Resources::Ingredient < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :cocktail_ingredients, as: :has_many
    field :cocktails, as: :has_many, through: :cocktail_ingredients
  end
end
