require 'spec_helper'

feature 'Parker cannot register a spot already in use', %Q{
  As a parker
  I cannot check in to a spot that has already been checked in
  So that two cars are not parked in the same spot
  } do
  #
  # Acceptance Criteria
  #
  # * If I specify a parking spot that has already been checked in for the day, I am told I can't check in there.
  # * If I specify a spot that hasn't yet been parked in today, I am able to check in 

  scenario 'when a spot is taken it cannot be checked in to' do
    registration = FactoryGirl.create(:parking_registration, spot_number: 8, day_of: Date.today)
    prev_count = ParkingRegistration.count
    visit '/'
    fill_in 'First name', with: 'Enka'
    fill_in 'Last name', with: 'Takahira'
    fill_in 'Email', with: 'edurr@aol.com'
    select 8, from: 'Spot number'
    click_button 'Register'
    expect(page).to_not have_content('Your spot has been registered')
    expect(page).to have_content("Spot number has already been taken")
    expect(ParkingRegistration.count).to eql(prev_count)
  end
end
