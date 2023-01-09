require 'rails_helper'

RSpec.describe 'Dish show' do
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

  it 'Shows the dish information' do
    visit dish_path(@mushris)

    expect(page).to have_content(@mushris.name)
    expect(page).to have_content(@mushris.description)
    expect(page).to_not have_content(@truffpiz.description)
    expect(page).to have_content(@gordon.name)
    expect(page).to have_content('88 calories')
    expect(page).to have_content(@truffle.name)
    expect(page).to have_content(@rice.name)
    expect(page).to have_content(@parm.name)
  end
end