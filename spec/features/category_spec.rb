require 'rails_helper'

RSpec.feature "Categories", type: :feature do
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
  end

  describe 'Category Index page' do
    scenario 'should have a category index page' do
      visit users_path
      visit categories_path
      expect(page).to have_content('CATEGORIES')
    end

    scenario 'should have category details link' do
      visit users_path
      visit categories_path
      expect(page).to have_content('New category')
    end

    scenario 'should havethe route to category details link' do
      visit users_path
      visit categories_path
      expect(page).to have_content('New category')
    end
  end

  describe 'Category Details page' do
    scenario 'should show category details page' do
      visit users_path
      visit category_path(@category)
      expect(page).to have_content('New Transaction')
    end

    scenario 'should show category name in details page' do
      visit users_path
      visit category_path(@category)
      expect(page).to have_content(@category.name)
    end
  end

  describe 'New Category page' do
    scenario 'should have a new category page file input' do
      visit users_path
      visit new_category_path
      expect(page).to have_content('Back to categories')
    end
  end
end
