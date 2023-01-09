class ChefDishesController < ApplicationController
  def create
    ChefDish.create!(chef_dishes_params)
    redirect_to chef_path(params[:chef_id])
  end

  private

  def chef_dishes_params
    params.permit(:dish_id, :chef_id)
  end
end