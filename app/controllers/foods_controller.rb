class FoodsController < ApplicationController
  
  def index
    @user = User.includes(:foods).find(current_user.id)
    @foods = @user.foods
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(foods_params)
    authorize! :create, @food
    
    if @food.valid?
      @food.save
      flash[:notice] = 'Food added successfully'
      redirect_to foods_path
    else
      flash[:alert] = 'Food not added'
      @error = @food.errors.full_messages
      render :new
    end
  end

  def destroy
    food = Food.find(params[:id])
    authorize! :destroy, food
    food.destroy
    
    flash[:notice] = 'Food has been deleted!'
    redirect_to foods_path
  end

  private

  def foods_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity).merge(user: current_user)
  end
end
