require 'rails_helper'

RSpec.describe ChefDish, type: :model do
  describe "relationships" do
    it {should belong_to :dish}
    it {should belong_to :chef}
  end
end