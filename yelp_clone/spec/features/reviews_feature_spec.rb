feature 'reviews', focus: true do

  context 'ratings' do
    before do
      Restaurant.create(name: 'Pret')
    end

    scenario 'leave a numerical rating for a restaurant' do
      visit '/restaurants'
      click_link 'Review Pret'
      select '4', from: 'review_rating'
      click_button 'Submit'
      expect(page).to have_content('Pret')
      expect(page).to have_content('4')
    end
  end
end
