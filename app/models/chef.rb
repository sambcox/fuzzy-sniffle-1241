class Chef < ApplicationRecord
  validates_presence_of :name
  has_many :chef_dishes
  has_many :dishes, through: :chef_dishes
  has_many :ingredients, through: :dishes

  def ingredient_list
    ingredients.distinct
  end

  def top_three_ingredients
    ingredients.joins(:dish_ingredients).select('ingredients.*, COUNT(distinct dish_ingredients.dish_id) as dish_count').order('dish_count DESC').group(:id).limit(3)
  end
end