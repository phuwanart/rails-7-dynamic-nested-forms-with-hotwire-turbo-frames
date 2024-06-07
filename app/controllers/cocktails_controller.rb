# frozen_string_literal: true

class CocktailsController < ApplicationController
  before_action :set_cocktail, only: %i[show edit update destroy]

  # GET /cocktails or /cocktails.json
  def index
    @search = ransack_params
    # @search.sorts = ['name desc', 'recipe'] if @search.sorts.empty?
    # @search.build_condition
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
    params.require(:cocktail).permit(:name, :recipe,
                                     cocktail_ingredients_attributes: %i[id quantity ingredient_id _destroy])
  end

  def ransack_params
    Cocktail.ransack(params[:q])
  end

  def ransack_result
    @search.result(distinct: true)
  end
end
