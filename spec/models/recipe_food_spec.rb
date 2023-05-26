require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { User.new(name: 'Nelson', email:'nels@nels.com', password:'shinra') }
  let(:recipe) { Recipe.new(user_id: user.id, description:'This is my description', name: 'Recipe 1', public: true, preparation_time: 1.0, cooking_time: 1.0) }
  let(:food) { Food.new(user_id: user.id, name:'Apple', measurement_unit: 'grams', price: 10, quantity: 10) }
  subject {RecipeFood.new(food_id: food.id, recipe_id: recipe.id, quantity: 2)}
  before do
    user.save
    recipe.save
    food.save
    subject.save
  end
  
  it 'Quantity should be present, expected false' do
    subject.quantity = nil
    expect(subject).to_not be_valid
  end

  it 'Quantity should be greater than 0, expected false' do
    subject.quantity = 0
    expect(subject).to_not be_valid
  end

  it 'Quantity should be present, expected true' do
    expect(subject).to be_valid
  end
end
