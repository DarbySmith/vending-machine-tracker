require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
  end
  
  describe 'relationships' do
    it { should belong_to :owner }
    it { should have_many :machine_snacks}
    it { should have_many(:snacks).through(:machine_snacks)}
  end

  before(:each) do
    @owner_1 = Owner.create!(name: 'Chris')
    @machine_1 = Machine.create!(location: 'Braselton', owner_id: @owner_1.id)
    @snack_1 = @machine_1.snacks.create!(name: 'Cheetos', price: 1.75)
    @snack_2 = @machine_1.snacks.create!(name: 'Oatmeal Pie', price: 1.25)
    @snack_3 = @machine_1.snacks.create!(name: 'Granola Bar', price: 2.25)
  end

  describe 'instance methods' do
    it 'shows the average price for all snacks in the machine' do
      expect(@machine_1.average_price_snacks).to eq(1.75)
    end
  end
end
