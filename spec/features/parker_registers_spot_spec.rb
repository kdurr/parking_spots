require 'spec_helper'

feature 'Parker registers a parking spot', %Q{
  As a parker
  I want to register my spot with my name
  So that the parking company can identify my car
  } do
  #
  # Acceptance Criteria
  #
  # * I must specify a first name, last name, email, and parking spot number
  # * I must enter a vlid parking spot number (the lot has spots identified as numbers 1-60)
  # * I must enter a valid email

  scenario 'register a spot with identifying information' do
    prev_count = ParkingRegistration.count
    visit '/'
    fill_in 'First name', with: 'Tina'
    fill_in 'Last name', with: 'Durr'
    fill_in 'Email', with: 'tinadurr@bellsouth.net'
    select 32, from: 'Spot number'
    click_button 'Register'
    expect(page).to have_content('Your spot has been registered')
    expect(ParkingRegistration.count).to eql(prev_count + 1)
  end
end