class RecipesController < ApplicationController
  def index
    @user = User.includes(:recipes).find(current_user.id)
    @recipes = @user.recipes
  end

  def show
    @recipe = Recipe.includes(recipe_foods: :food).find(params[:id])
    @foods = Food.all
    @recipes_foods = @recipe.recipe_foods
  end

  def new
    new_recipe = Recipe.new
    respond_to do |format|
      format.html { render :new, locals: { recipe: new_recipe } }
    end
  end

  def create
    @new_recipe = Recipe.new(params.require(:recipe).permit(:name, :public, :cooking_time, :preparation_time,
                                                            :description))
    @new_recipe.user = current_user
    respond_to do |format|
      if @new_recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'Recipe was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    flash[:notice] = 'Recipe has been deleted!'
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:public)
  end
end
