def create_new_restaurant_jasmine
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'Jasmine'
  fill_in 'Description', with: 'Tasty, quick food'
  click_button 'Create Restaurant'
end

def create_review_for_pret
  visit '/restaurants'
  click_link 'Pret'
  click_link 'Review Pret'
  fill_in 'Comment', with: 'Very nice'
  select '4', from: 'Rating'
  click_button 'Submit Review'
end
