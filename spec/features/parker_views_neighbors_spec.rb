require 'spec_helper'

feature 'Parker can view neighbors', %Q{
  As a parker
  I want to see my two neighbors
  So that I can be a creeper
  } do
  #
  # Acceptance Criteria
  #
  # * After checking in, if I have a neighbor in a slot 1 below me, or one above me, I am informed of their name and
  #   what slot number they are currently in
  # * If I do not have anyone parking next to me, I am told that I have no current neighbors

  scenario 'no immediate neighbors' do
    visit '/'
    fill_in 'First name', with: 'Tina'
    fill_in 'Last name', with: 'Durr'
    fill_in 'Email', with: 'tinadurr@bellsouth.net'
    select 54, from: 'Spot number'
    click_button 'Register'
    expect(page).to have_content('Sad day, you have no neighbors')
  end

  scenario 'see the neighbor one spot below me' do
    below_spot = FactoryGirl.create(:parking_registration, first_name: 'Jake', last_name: 'Meyer', spot_number: 7)
    visit '/'
    fill_in 'First name', with: 'Tina'
    fill_in 'Last name', with: 'Durr'
    fill_in 'Email', with: 'tina@bellsouth.net'
    select 8, from: 'Spot number'
    click_button 'Register'
    expect(page).to have_content("Your neighbor is Jake")
  end

  scenario 'see the neighbor one spot above me' do
    above_spot = FactoryGirl.create(:parking_registration, first_name: 'John', last_name: 'Meyer', spot_number: 9)
    visit '/'
    fill_in 'First name', with: 'Tina'
    fill_in 'Last name', with: 'Durr'
    fill_in 'Email', with: 'tina@bellsouth.net'
    select 8, from: 'Spot number'
    click_button 'Register'
    expect(page).to have_content("Your neighbor is John")
  end

  scenario 'see the neighbor one spot above me' do
    below_spot = FactoryGirl.create(:parking_registration, first_name: 'Jake', last_name: 'Meyer', spot_number: 7)
    above_spot = FactoryGirl.create(:parking_registration, first_name: 'John', last_name: 'Meyer', spot_number: 9)
    visit '/'
    fill_in 'First name', with: 'Tina'
    fill_in 'Last name', with: 'Durr'
    fill_in 'Email', with: 'tina@bellsouth.net'
    select 8, from: 'Spot number'
    click_button 'Register'
    expect(page).to have_content("Your neighbors are Jake & John")
  end

end