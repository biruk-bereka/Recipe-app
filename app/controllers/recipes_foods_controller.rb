class RecipesFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
  end

  def create
    @new_recipe_food = RecipeFood.new(recipe_params)
    @new_recipe_food.recipe_id = params[:recipe_id]
    respond_to do |format|
      if @new_recipe_food.save
        format.html { redirect_to "/recipes/#{params[:recipe_id]}", notice: 'Recipe_food was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
        @error = @new_recipe_food.errors.full_messages
        puts @error
      end
    end
  end

  def edit
    # here is the update problem
    @recipe_food = RecipeFood.includes(:food, :recipe).find(params[:id])
    @food = @recipe_food.food
    @recipe = @recipe_food.recipe
    if @recipe_food.update(recipe_params)
      redirect_to recipes_path(@recipe_food.recipe_id), notice: 'Recipe_food was successfully updated.'
    else
      render :edit
    end
  end

  def update
    # here is the update problem
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(recipe_params)
      redirect_to recipes_path(@recipe_food.recipe_id), notice: 'Recipe_food was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    recipe_food = RecipeFood.find(params[:id])
    recipe_food.destroy
    flash[:notice] = 'Recipe has been deleted!'
    redirect_to "/recipes/#{params[:recipe_id]}"
  end

  private

  def recipe_params
    # here is the update problem
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
