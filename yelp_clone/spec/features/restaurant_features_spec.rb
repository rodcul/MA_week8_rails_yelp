require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants added yet' do
    scenario 'prompt to add a restaurant' do
      visit('/restaurants')
      expect(page).to have_content('No restaurants yet!')
      expect(page).to have_link('Add a restaurant')
    end
  end

  context 'restaurant added' do
   before do
      Restaurant.create(name: 'MaccyDs')
    end
    scenario 'display restaurants' do
      visit('/restaurants')
      expect(page).to have_content('MaccyDs')
      expect(page).not_to have_content('No restaurants yet!')
    end
  end
end