class Review < ActiveRecord::Base
  belongs_to :restaurant
  #belongs_to :user - to come
end
