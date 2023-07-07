require 'rails_helper'

RSpec.describe Payment, type: :model do
  before(:each) do
    @user = User.create(name: 'Mohammad Rafi Amin', email: 'mrkamin2@gmail.com', password: '123456')

    @category = Category.create(name: 'Foode', icon: 'http://foodicon.com', user_id: @user.id)

    @payment = Payment.create(name: 'Ricee', amount: 50, user_id: @user.id)
  end

  it 'is not valid without a name' do
    @payment.name = nil
    expect(@payment).to_not be_valid
  end
  it 'is not valid without an amount' do
    @payment.amount = nil
    expect(@payment).to_not be_valid
  end
  it 'is not valid without a user_id' do
    @payment.user_id = nil
    expect(@payment).to_not be_valid
  end
end
