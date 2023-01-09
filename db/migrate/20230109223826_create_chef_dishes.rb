class CreateChefDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :chef_dishes do |t|
      t.references :dish, foreign_key: true
      t.references :chef, foreign_key: true
    end
  end
end
