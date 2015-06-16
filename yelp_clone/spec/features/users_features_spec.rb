require 'rails_helper'

feature 'User sign in and out' do
  context 'User is not signed in and on the home-page' do
    it "should see a sign in and sign up link" do
      visit ('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not be able to see sign-out link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end

    it "should not be able to see 'add a restaurant' link" do
      visit '/'
      click_link 'Add a restaurant'
      expect(page).not_to have_button('Create Restaurant')
      expect(current_path).to eq new_user_session_path
    end
  end

  context "User is signed in and on the home-page" do
    before do
      visit ('/')
      click_link('Sign up')
      fill_in("Email", with: 'test@example.com')
      fill_in("Password", with: 'testtest')
      fill_in("Password confirmation", with: 'testtest')
      click_button('Sign up')
    end

    it "should see a sign-out link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see sign-in and sign-up" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

    it "and can only leave one review per restaurant" do
      visit '/'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link 'Review KFC'
      fill_in 'Thoughts', with: 'so so'
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(page).to have_content 'so so 3/5'
      expect(page).not_to have_link('Review KFC')
    end
  end

  context "User has signed in and added a restaurant" do
    before do
      visit ('/')
      click_link('Sign up')
      fill_in("Email", with: 'test@example.com')
      fill_in("Password", with: 'testtest')
      fill_in("Password confirmation", with: 'testtest')
      click_button('Sign up')
      click_link('Add a restaurant')
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link('Sign out')

      visit ('/')
      click_link('Sign up')
      fill_in("Email", with: 'test2@example.com')
      fill_in("Password", with: 'testtest2')
      fill_in("Password confirmation", with: 'testtest2')
      click_button('Sign up')
      click_link('Add a restaurant')
      fill_in 'Name', with: 'MaccyDs'
      click_button 'Create Restaurant'
      click_link('Sign out')
    end

    it "can only edit an entry they have created" do
        visit('/')
        click_link('Sign in')
        fill_in("Email", with: 'test@example.com')
        fill_in("Password", with: 'testtest')
        click_button('Log in')
        expect(page).to have_link('Edit KFC')
        expect(page).not_to have_link('Edit MaccyDs')
    end
  end
end
