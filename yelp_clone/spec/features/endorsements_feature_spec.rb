require 'rails_helper'

feature 'endorsements' do
  before do
    kfc = Restaurant.create(name: 'kfc')
    kfc.reviews.create(thoughts: 'crappy', rating: 1)
  end

  scenario 'can endorse Restaurants, which increments the endoresement counter', js: true do
    visit('/restaurants')
    click_link 'Endorse kfc'
    expect(page).to have_content('1 endorsement')
  end

end