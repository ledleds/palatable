feature 'reviews', focus: true do

  context 'ratings' do
    before do
      Restaurant.create(name: 'Pret')
    end

    scenario 'leave a numerical rating for a restaurant' do
      visit '/restaurants'
      click_link 'Pret'
      expect(page).to have_content('Pret')
      click_link 'Review Pret'
      select '4', from: 'Rating'
      click_button 'Submit Review'
      expect(page).to have_content('Pret')
    end
  end
end
