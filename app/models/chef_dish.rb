class ChefDish < ApplicationRecord
  belongs_to :chef
  belongs_to :dish
end