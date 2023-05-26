require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.new(name: 'Nelson', email: 'nels@nels.com', password: 'shinra') }
  subject { Food.new(user_id: user.id, name: 'Apple', measurement_unit: 'grams', price: 10, quantity: 10) }
  before do
    user.save
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

  it 'Price should be present, expected false' do
    subject.price = nil
    expect(subject).to_not be_valid
  end

  it 'Price should be greater than 0, expected false' do
    subject.price = 0
    expect(subject).to_not be_valid
  end

  it 'Price should be present, expected true' do
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

  it 'measurement_unit should be less than 250 characters, expected false' do
    t = 'This must be a very long text to test the max length of a post it is supouse to be less than 250'
    t1 = 'character, for that i am goint to improvise some custom text, and this test'
    t2 = 'must be false because we are passing rigth know the 200 hundred characters and we are '
    t3 = 'close to our goal, Yes we did it!!!'
    subject.measurement_unit = t + t1 + t2 + t3
    expect(subject).to_not be_valid
  end
end
