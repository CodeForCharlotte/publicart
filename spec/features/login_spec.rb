require 'rails_helper'

RSpec.describe "Logging in", :type => :feature do
  let(:user) { create(:user) }

  before(:each) do
    visit new_user_session_path
  end

  it "signs me in" do
    save_and_open_page
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content 'Signed in successfully.'
  end

  it "doesn't sign me in with invalid email" do
    fill_in 'Email', with: 'invalid email'
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content 'Invalid Email or password'
  end

  it "doesn't sign me in with invalid password" do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'invalid password'
    click_button 'Log in'

    expect(page).to have_content 'Invalid Email or password'
  end
end
