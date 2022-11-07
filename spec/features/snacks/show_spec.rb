require 'rails_helper'

RSpec.describe 'snack show page' do
  before(:each) do
    @owner_1 = Owner.create!(name: 'Chris')
    @owner_2 = Owner.create!(name: 'Abdul')

    @machine_1 = Machine.create!(location: 'Braselton', owner_id: @owner_1.id)
    @machine_2 = Machine.create!(location: 'Tate', owner_id: @owner_1.id)
    @machine_3 = Machine.create!(location: 'Bolton', owner_id: @owner_2.id)
    @machine_4 = Machine.create!(location: 'MLC', owner_id: @owner_2.id)
    
    @snack_1 = Snack.create!(name: 'Cheetos', price: 1.75)
    @snack_2 = Snack.create!(name: 'Oatmeal Pie', price: 1.25)
    @snack_3 = Snack.create!(name: 'Granola Bar', price: 2.25)
    @snack_4 = Snack.create!(name: 'Moon Pie', price: 1.15)
    @snack_5 = Snack.create!(name: 'Cinnamon Roll', price: 2.75)

    MachineSnack.create!(machine: @machine_1, snack: @snack_1)
    MachineSnack.create!(machine: @machine_1, snack: @snack_2)
    MachineSnack.create!(machine: @machine_1, snack: @snack_3)
    MachineSnack.create!(machine: @machine_1, snack: @snack_4)
    
    MachineSnack.create!(machine: @machine_2, snack: @snack_2)
    MachineSnack.create!(machine: @machine_2, snack: @snack_3)
    MachineSnack.create!(machine: @machine_2, snack: @snack_4)
    MachineSnack.create!(machine: @machine_2, snack: @snack_5)
    
    MachineSnack.create!(machine: @machine_3, snack: @snack_1)
    MachineSnack.create!(machine: @machine_3, snack: @snack_3)
    MachineSnack.create!(machine: @machine_3, snack: @snack_4)
    MachineSnack.create!(machine: @machine_3, snack: @snack_5)
   
    MachineSnack.create!(machine: @machine_4, snack: @snack_1)
    MachineSnack.create!(machine: @machine_4, snack: @snack_2)
    MachineSnack.create!(machine: @machine_4, snack: @snack_4)
    MachineSnack.create!(machine: @machine_4, snack: @snack_5)
  end

  it 'shows the name of the snack, price, locations that have that snack, and count of different items in that vending machine' do
    visit "/snacks/#{@snack_1.id}"

    expect(page).to have_content(@snack_1.name)
    expect(page).to have_content(@snack_1.price)

    within("#machine-#{@machine_1.id}") do
      expect(page).to have_content(@machine_1.location)
      expect(page).to have_content("Braselton (4 kinds of snacks, average price of $1.6")
    end
    
    within("#machine-#{@machine_3.id}") do
      expect(page).to have_content(@machine_3.location)
      expect(page).to have_content("Bolton (4 kinds of snacks, average price of $1.98")
    end

    within("#machine-#{@machine_4.id}") do
      expect(page).to have_content(@machine_4.location)
      expect(page).to have_content("MLC (4 kinds of snacks, average price of $1.73")
    end
    
    expect(page).to_not have_content(@machine_2.location)
  end
end