require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :chef_dishes}
    it {should have_many(:dishes).through :chef_dishes}
    it {should have_many(:ingredients).through :dishes}
  end

  describe 'instance methods' do
    before(:each) do
      @guy = Chef.create!({name: 'Guy Fieri'})
      @gordon = Chef.create!({name: 'Gordon Ramsay'})

      @mushris = @gordon.dishes.create!({name: 'Mushroom Risotto', description: 'A beautifully light mushroom risotto that will make you feel amazing.'})
      @truffpiz = @gordon.dishes.create!({name: 'Truffle Pizza', description: 'A wonderfully flavorful pizza, strong in truffle flavor'})

      @burger = @guy.dishes.create!({name: 'Cheeseburger', description: 'Man, this burger is going to make you sweat, but it tastes great.'})
      @friedrice = @guy.dishes.create!({name: 'Buttery Fried Rice', description: 'Dude, you might have a heart attack after, but it will be the most enjoyable heart attack of all time.'})
      @bacon = @guy.dishes.create!({name: 'Bacon', description: 'What more can you say about bacon?'})

      @truffle = Ingredient.create!({name: 'Truffle Mushroom', calories: 15})
      @rice = Ingredient.create!({name: 'Rice', calories: 45})
      @parm = Ingredient.create!({name: 'Parmesan', calories: 28})
      @mince = Ingredient.create!({name: 'Ground Beef', calories: 500})
      @egg = Ingredient.create!({name: 'Egg', calories: 250})
      @raw_bacon = Ingredient.create!({name: 'Bacon', calories: 600})

      DishIngredient.create!({dish_id: @mushris.id, ingredient_id: @truffle.id})
      DishIngredient.create!({dish_id: @truffpiz.id, ingredient_id: @truffle.id})
      DishIngredient.create!({dish_id: @mushris.id, ingredient_id: @rice.id})
      DishIngredient.create!({dish_id: @friedrice.id, ingredient_id: @rice.id})
      DishIngredient.create!({dish_id: @mushris.id, ingredient_id: @parm.id})
      DishIngredient.create!({dish_id: @truffpiz.id, ingredient_id: @parm.id})
      DishIngredient.create!({dish_id: @burger.id, ingredient_id: @parm.id})
      DishIngredient.create!({dish_id: @burger.id, ingredient_id: @mince.id})
      DishIngredient.create!({dish_id: @friedrice.id, ingredient_id: @egg.id})
      DishIngredient.create!({dish_id: @bacon.id, ingredient_id: @raw_bacon.id})
    end
    it 'returns the distinct ingredients for a chef' do
      expect(@guy.ingredient_list.sort).to eq([@rice, @parm, @mince, @egg, @raw_bacon])
    end
  end
end