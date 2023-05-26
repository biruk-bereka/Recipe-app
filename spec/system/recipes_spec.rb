require 'rails_helper'

RSpec.describe Recipe, type: :system do
  let(:user) { User.new(name: 'Nelson', email:'nels@nels.com', password:'shinra') }
  subject { Recipe.new(user_id: user.id, description:'This is my description', name: 'Recipe 1', public: true, preparation_time: 1.0, cooking_time: 1.0) }

  before do 
    ActionMailer::Base.deliveries.clear
    user.save
    subject.save
  end

  # INDEX PAGE CAPYBARA
  it 'show the recipes list' do
    
    visit new_user_registration_path
    # Fill in the sign-in form with valid user credentials
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'

    # Retrieve the confirmation email
    path_regex = /(?:"https?\:\/\/.*?)(\/.*?)(?:")/
    email = ActionMailer::Base.deliveries.last
    path = email.body.match(path_regex)[1]

    # Visit the confirmation link
    visit path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    visit recipes_path
    expect(page).to have_content(subject.name)
  end

  it 'create recipe' do
    
    visit new_user_registration_path
    # Fill in the sign-in form with valid user credentials
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'

    # Retrieve the confirmation email
    path_regex = /(?:"https?\:\/\/.*?)(\/.*?)(?:")/
    email = ActionMailer::Base.deliveries.last
    path = email.body.match(path_regex)[1]

    # Visit the confirmation link
    visit path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit recipes_path

    click_button 'Add Recipe'

    expect(page).to have_current_path(root_path)
    
  end

end
