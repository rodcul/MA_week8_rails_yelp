require 'rails_helper'

feature 'reviewing' do
  before do
    visit ('/')
    click_link('Sign up')
    fill_in("Email", with: 'test@example.com')
    fill_in("Password", with: 'testtest')
    fill_in("Password confirmation", with: 'testtest')
    click_button('Sign up')
    click_link('Add a restaurant')
    fill_in 'Name', with: 'MaccyDs'
    click_button 'Create Restaurant'
  end

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link 'Review MaccyDs'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end

  scenario 'allow users to leave reviews' do
    visit '/restaurants'
    click_link 'Review MaccyDs'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'displays an average rating for all reviews of a restaurant' do
    leave_review('So, so', '3')
    leave_review('Awesome', '5')
    expect(page).to have_content('Average rating: ★★★★☆')
  end

end