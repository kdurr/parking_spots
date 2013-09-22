require 'spec_helper'

feature 'Parker knows where they parked yesterday', %Q{
  As a Parker
  I want to know what spot I parked in yesterday
  So that I can determine if I'm parking in the same spot and whether it is 
    already filled in or if it is available
  } do
  #
  # Acceptance Criteria
  #
  # * If I parked yesterday, the system tells me where I parked yesterday 
  #   when checking in
  # * If I did not park yesterday, the system tells me that I did not park
  #   yesterday when checking in 
  # * If I parked before today, the system prefills my spot number with 
  #   the spot I last parked in
  # * If I have not parked, the system does not prefill the spot number

  scenario 'system tells parker where they parked yesterday if they did park yesterday' do
    visit '/'
    fill_in 'First name', with: 'Enka'
    fill_in 'Last name', with: 'Takahira'
    fill_in 'Email', with: 'enka@fan.com'
    select 20, from: 'Spot number'
    click_button 'Register'
    ParkingRegistration.first.update(day_of: Date.yesterday)
    previous_spot = ParkingRegistration.first.spot_number

    visit '/parking_registrations/new'

    expect(page).to have_content("Yesterday you parked in spot 20" )
  end

  scenario 'system tells parker they did not park yesterday if they did not' do
    visit '/parking_registrations/new'
    expect(page).to have_content("You did not park here yesterday" )
  end

  scenario 'system pre-sets the parking spot to the spot previously parked in' do
    visit new_parking_registration_path
    fill_in 'First name', with: 'Enka'
    fill_in 'Last name', with: 'Takahira'
    fill_in 'Email', with: 'enka@fan.com'
    select 20, from: 'Spot number'
    click_button 'Register'
    ParkingRegistration.first.update(day_of: Date.yesterday)
    previous_spot = ParkingRegistration.first.spot_number

    visit new_parking_registration_path
    expect(page).to have_select('Spot number', :selected => "20")
  end
end