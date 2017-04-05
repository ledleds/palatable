class RemoveRatingColumn < ActiveRecord::Migration
  def change
    remove_column :restaurants, :rating, :integer
  end
end
