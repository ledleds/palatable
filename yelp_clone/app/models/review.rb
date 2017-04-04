class Review < ActiveRecord::Base
  belongs_to :restaurant, dependent :destroy
  # belongs_to :user - to come
end
