require 'rails_helper'

RSpec.feature "Users", type: :feature do
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
  end

  scenario 'I can see the user name on users index page.' do
    visit users_path
    expect(page).to have_content(@user.name)
  end

  scenario 'I can see the user id on users index page.' do
    visit users_path
    expect(page).to have_content(@user.id)
  end

  scenario 'I can see the user email on users index page.' do
    visit users_path
    expect(page).to have_content(@user.email)
  end
end
