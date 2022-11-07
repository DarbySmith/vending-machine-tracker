require 'rails_helper'

RSpec.describe 'vending machine show page' do
  before(:each) do
    @owner_1 = Owner.create!(name: 'Chris')
    @machine_1 = Machine.create!(location: 'Braselton', owner_id: @owner_1.id)
    @snack_1 = @machine_1.snacks.create!(name: 'Cheetos', price: 1.75)
    @snack_2 = @machine_1.snacks.create!(name: 'Oatmeal Pie', price: 1.25)
    @snack_3 = @machine_1.snacks.create!(name: 'Granola Bar', price: 2.25)
  end
  
  it 'shows names of all snacks associated with that vending machine and their price' do
    visit "/machines/#{@machine_1.id}"
    
    within("#snack-#{@snack_1.id}") do
      expect(page).to have_content(@snack_1.name)
      expect(page).to have_content(@snack_1.price)
    end

    within("#snack-#{@snack_2.id}") do
      expect(page).to have_content(@snack_2.name)
      expect(page).to have_content(@snack_2.price)
    end

    within("#snack-#{@snack_3.id}") do
      expect(page).to have_content(@snack_3.name)
      expect(page).to have_content(@snack_3.price)
    end
    save_and_open_page
  end

  it 'shows the average price of all snacks in the machine on show page' do
    visit "/machines/#{@machine_1.id}"
    
    expect(page).to have_content("Average Price: $1.75")
  end
end