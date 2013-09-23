require 'spec_helper'

feature 'Parker sees all past parking activity', %Q{
  As a Parker
  I want to see a list of my parking activity
  So that I can see where I've parked over time
  } do
  #
  # Acceptance Criteria
  #
  # * When checking in, if I've previously checked in with the same email, I am given the 
  #   option to see parking activity
  # * If I opt to see parking activity, I am shown all of my check-ins sorted in reverse chronological order
  #   I can see the spot number and the day and time I check in
  # * If I have not previously checked in, I do not have the option to see parking activity

  # ParkingRegistration.where(email: 'yh@fan.com').order('created_at DESC').select("spot_number", "created_at")

  scenario 'when parker opts to see activity it is in reverse chronological order with spot, day and time' do
    visit new_parking_registration_path
    fill_in 'First name', with: 'Enka'
    fill_in 'Last name', with: 'Takahira'
    fill_in 'Email', with: 'enka@fan.com'
    select 20, from: 'Spot number'
    click_button 'Register'
    ParkingRegistration.first.update(day_of: Date.yesterday)
    visit new_parking_registration_path
    click_link 'Previous Parking Activity'
    expect(page).to have_content("20")
    expect(page).to have_content(:created_at)
  end

  scenario 'parker cannot see parking activity if they have not previously checked in' do
    visit new_parking_registration_path
    expect(page).to_not have_content('Previous Parking Activity')
  end
end