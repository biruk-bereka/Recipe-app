require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.new(name: 'Nelson', email: 'nels@nels.com', password: 'shinra') }
  subject do
    Recipe.new(user_id: user.id, description: 'This is my description', name: 'Recipe 1', public: true,
               preparation_time: 1.0, cooking_time: 1.0)
  end

  before do
    user.save
    subject.save
  end

  it 'name should be present, expected false' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should be present, expected true' do
    expect(subject).to be_valid
  end

  it 'preparation_time should be present, expected false' do
    subject.preparation_time = nil
    expect(subject).to_not be_valid
  end

  it 'preparation_time should be greater than 0, expected false' do
    subject.preparation_time = 0
    expect(subject).to_not be_valid
  end

  it 'preparation_time should be present, expected true' do
    expect(subject).to be_valid
  end

  it 'cooking_time should be present, expected false' do
    subject.cooking_time = nil
    expect(subject).to_not be_valid
  end

  it 'cooking_time should be greater than 0, expected false' do
    subject.cooking_time = 0
    expect(subject).to_not be_valid
  end

  it 'cooking_time should be present, expected true' do
    expect(subject).to be_valid
  end

  it 'name should be less than 250 characters, expected false' do
    t = 'This must be a very long text to test the max length of a post it is supouse to be less than 250'
    t1 = 'character, for that i am goint to improvise some custom text, and this test'
    t2 = 'must be false because we are passing rigth know the 200 hundred characters and we are '
    t3 = 'close to our goal, Yes we did it!!!'
    subject.name = t + t1 + t2 + t3
    expect(subject).to_not be_valid
  end

  it 'description should be less than 250 characters, expected false' do
    t = 'This must be a very long text to test the max length of a post it is supouse to be less than 250'
    t1 = 'character, for that i am goint to improvise some custom text, and this test'
    t2 = 'must be false because we are passing rigth know the 200 hundred characters and we are '
    t3 = 'close to our goal, Yes we did it!!!'
    subject.description = t + t1 + t2 + t3
    expect(subject).to_not be_valid
  end
end
