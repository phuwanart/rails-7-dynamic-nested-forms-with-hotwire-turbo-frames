# frozen_string_literal: true

class CocktailsController < ApplicationController
  before_action :set_cocktail, only: %i[show edit update destroy]

  # GET /cocktails or /cocktails.json
  def index
    @search = ransack_params
    @search.sorts = ['name desc'] if @search.sorts.empty?
    # @search.build_condition
    @cocktails = ransack_result
  end

  def search
    @search = ransack_params
    @cocktails  = ransack_result
  end

  # GET /cocktails/1 or /cocktails/1.json
  def show; end

  # GET /cocktails/new
  def new
    @cocktail = Cocktail.new
  end

  # GET /cocktails/1/edit
  def edit; end

  # POST /cocktails or /cocktails.json
  def create
    @cocktail = Cocktail.new(cocktail_params)

    respond_to do |format|
      if @cocktail.save
        format.html { redirect_to cocktail_url(@cocktail), notice: 'Cocktail was successfully created.' }
        format.json { render :show, status: :created, location: @cocktail }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cocktail.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_ingredient
    helpers.fields model: Cocktail.new do |f|
      f.fields_for :cocktail_ingredients, CocktailIngredient.new,
                   child_index: Process.clock_gettime(Process::CLOCK_REALTIME, :millisecond) do |ff|
        render turbo_stream: turbo_stream.append(
          'cocktail_ingredients',
          partial: 'ingredient_fields',
          locals: { f: ff }
        )
      end
    end
  end

  def add_fields
    form_model, *nested_attributes = params[:name].split(/\[|\]/).compact_blank
    helpers.fields form_model.classify.constantize.new do |form|
      nested_form_builder_for form, nested_attributes do |f|
        # NOTE: this block should run only once for the last association
        #       cocktail[cocktail_ingredients_attributes]
        #           this ^^^^^^^^^^^^^^^^^^^^        or this vvvvvv
        #       cocktail[cocktail_ingredients_attributes][0][things_attributes]
        #
        #       `f` is the last nested form builder, for example:
        #
        #         form_with model: Model.new do |f|
        #           f.fields_for :one do |ff|
        #             ff.fields_for :two do |fff|
        #               yield fff
        #               #     ^^^
        #               # NOTE: this is what you should get in this block
        #             end
        #           end
        #         end
        #
        render turbo_stream: turbo_stream.append(
          params[:name].parameterize(separator: '_'),
          partial: "#{f.object.class.name.underscore}_fields",
          locals: { f: }
        )
      end
    end
  end

  # PATCH/PUT /cocktails/1 or /cocktails/1.json
  def update
    respond_to do |format|
      if @cocktail.update(cocktail_params)
        format.html { redirect_to cocktail_url(@cocktail), notice: 'Cocktail was successfully updated.' }
        format.json { render :show, status: :ok, location: @cocktail }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cocktail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cocktails/1 or /cocktails/1.json
  def destroy
    @cocktail.destroy!

    respond_to do |format|
      format.html { redirect_to cocktails_url, notice: 'Cocktail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cocktail_params
    params.require(:cocktail).permit(
      :name,
      :recipe,
      cocktail_ingredients_attributes: {}
    )
  end

  def ransack_params
    Cocktail.ransack({ name_cont: 'xxx' })
  end

  def ransack_result
    @search.result(distinct: true)
  end

  def nested_form_builder_for f, *nested_attributes, &block
    attribute, index = nested_attributes.flatten!.shift(2)
    if attribute.blank?
      # NOTE: yield the last form builder instance to render the response
      yield f
      return
    end
    association = attribute.chomp('_attributes')
    child_index = index || Process.clock_gettime(Process::CLOCK_REALTIME, :millisecond)
    f.fields_for association, association.classify.constantize.new, child_index: do |ff|
      nested_form_builder_for(ff, nested_attributes, &block)
    end
  end
end
