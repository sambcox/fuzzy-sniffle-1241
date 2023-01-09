class Chef < ApplicationRecord
  validates_presence_of :name
  has_many :chef_dishes
  has_many :dishes, through: :chef_dishes
  has_many :ingredients, through: :dishes

  def ingredient_list
    ingredients.distinct
  end
end