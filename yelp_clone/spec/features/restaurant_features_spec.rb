require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants added yet' do
    scenario 'prompt to add a restaurant' do
      visit('/restaurants')
      expect(page).to have_content('No restaurants yet!')
      expect(page).to have_link('Add a restaurant')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'MaccyDs'
        click_button 'Create Restaurant'
        expect(page).to have_content('MaccyDs')
        expect(current_path).to eq '/restaurants'
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

  context 'viewing restaurants' do
    let!(:mcd){Restaurant.create(name:'MaccyDs')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'MaccyDs'
      expect(page).to have_content 'MaccyDs'
      expect(current_path).to eq "/restaurants/#{mcd.id}"
    end
  end

  context 'editing restaurants' do
    before {Restaurant.create(name: 'MaccyDs')}

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit MaccyDs'
      fill_in 'Name', with: 'McDonalds'
      click_button 'Update Restaurant'
      expect(page).to have_content('McDonalds')
      expect(current_path).to eq "/restaurants"
    end
  end
    context 'deleting restaurants' do
      before {Restaurant.create(name: 'MaccyDs')}

      scenario 'lets a user delete a restuarant' do
        visit '/restaurants'
        click_link 'Delete MaccyDs'
        expect(page).not_to have_content('MaccyDs')
        expect(page).to have_content 'Restaurant deleted successfully'
      end
    end
end
