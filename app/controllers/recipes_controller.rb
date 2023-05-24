class RecipesController < ApplicationController
  def index
    @user = User.includes(:recipes).find(current_user.id) 
    @recipes = @user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def new
    new_recipe = Recipe.new
    respond_to do |format|
      format.html { render :new, locals: { recipe: new_recipe } }
    end
  end

  def create
    @new_recipe = Recipe.new(params.require(:recipe).permit(:name, :public, :cooking_time, :preparation_time, :description))
    @new_recipe.user = current_user
    respond_to do |format|
      if @new_recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    flash[:notice] = 'Recipe has been deleted!'
    redirect_to recipes_path
  end
end
