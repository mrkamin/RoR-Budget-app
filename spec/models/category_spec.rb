require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) do
    @user = User.create(name: 'Mohammad Rafi Amin', email: 'mrkamin2@gmail.com', password: '123456')

    @category = Category.new(name: 'Food', icon: 'http://foodicon.com', user_id: @user.id)
  end
  it 'is valid with valid attributes' do
    expect(@category).to be_valid
  end

  it 'is not valid without a name' do
    @category.name = nil
    expect(@category).to_not be_valid
  end

  it 'is not valid without an icon' do
    @category.icon = nil
    expect(@category).to_not be_valid
  end

  it 'is not valid without a user_id' do
    @category.user_id = nil
    expect(@category).to_not be_valid
  end
end
