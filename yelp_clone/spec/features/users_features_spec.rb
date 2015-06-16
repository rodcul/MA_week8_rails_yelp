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
  end
end
