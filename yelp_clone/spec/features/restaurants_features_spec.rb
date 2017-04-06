feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants have been listed yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_up
      create_new_restaurant_jasmine
      expect(page).not_to have_content 'No restaurants have been listed yet'
      expect(page).to have_content 'Jasmine'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'only users can list restaurants' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(page).to have_content 'You need to sign in or sign up before continuing'
      expect(page).not_to have_content 'Name'
    end
  end

  context 'an invalid restaurant' do
    scenario 'does not let you submit a name that is too short' do
      sign_up
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Pr'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'Pr'
      expect(page).to have_content 'error'
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

    scenario 'average rating shows on index page and restaurant show page' do
      create_review_for_pret
      expect(page).to have_content "4"
      click_link 'Review Pret'
      fill_in 'Comment', with: 'Super'
      select '5', from: 'Rating'
      click_button 'Submit Review'
      expect(page).to have_content "4.5"
      visit '/restaurants'
      expect(page).to have_content "4.5"
    end
  end

  context 'editing restaurants' do

    before { Restaurant.create name: 'Pret', description: 'Tasty quick lunch', id: 1 }
    scenario 'let a user edit a restaurant' do
      sign_up
      visit '/restaurants'
      click_link 'Pret'
      click_link 'Edit Pret'
      fill_in 'Name', with: 'Pret'
      fill_in 'Description', with: 'Tasty quick lunch for people on the go'
      click_button 'Update Restaurant'
      click_link 'Pret'
      expect(page).to have_content 'Pret'
      expect(page).to have_content 'Tasty quick lunch for people on the go'
      expect(current_path).to eq '/restaurants/1'
    end

    scenario 'only users can edit restaurants' do
      visit '/restaurants'
      expect(page).not_to have_content 'Edit Pret'
    end
  end

  context 'deleting restaurants' do

    before { Restaurant.create name: 'Cafe', description: 'Unique' }

    scenario 'removes a restaurant when a user clicks a delete link' do
      sign_up
      visit '/restaurants'
      click_link 'Cafe'
      click_link 'Delete Cafe'
      expect(page).not_to have_content 'Cafe'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end
end
