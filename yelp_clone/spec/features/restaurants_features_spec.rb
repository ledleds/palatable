# require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'Pret')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Pret')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'viewing restaurants' do

    let!(:pret){ Restaurant.create(name: 'Pret') }

    scenario 'lets a user view a restaurant' do
     visit '/restaurants'
     click_link 'Pret'
     expect(page).to have_content 'Pret'
     expect(current_path).to eq "/restaurants/#{pret.id}"
    end
  end
end
