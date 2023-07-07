require 'rails_helper'

RSpec.feature 'Payments', type: :feature do
  before(:all) do
    Capybara.reset_sessions!
  end

  before(:each) do
    visit users_path
    @user = User.create(name: 'Mohammad Rafi Amin', email: 'mrkamin2@gmail.com', password: '123456')
    if page.current_path == new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
    end
    @category = Category.create(name: 'Food', icon: 'http://foodicon.com', user_id: @user.id)
    @payment = Payment.create(name: 'Rice', amount: 50, user_id: @user.id)
  end

  describe 'Payment index page' do
    scenario 'should show payment name in payment index page' do
      visit category_payments_path(@category)
      expect(page).to have_content('TRANSACTIONS')
    end

    scenario 'should have an category payment total' do
      visit category_payments_path(@category)
      expect(page).to have_content('Recent')
    end

    scenario 'should have an category payment total' do
      visit category_payments_path(@category)
      expect(page).to have_content('Ancient')
    end
  end

  describe 'New Payment page' do
    scenario 'should have a form for new payment' do
      visit users_path
      visit new_category_payment_path(@category)
      expect(page).to have_content('NEW PAYMENTS')
    end
  end
end
