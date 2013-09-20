require 'spec_helper'

feature 'Systems persists parker emails', %Q{
  As a parker
  I want the system to remember my emails
  So that I don't have to re-enter it
  } do
  #
  # Acceptance Criteria:
  #
  # * If I have previously checked in via the same web browser, my email is remembered so that I don't
  #   have to re-enter it
  # * If I have not previously checked in, the email address field is left blank
  
  scenario 'parker provides email and it is remembered on return' do
    email = 'enka@abc.com'

    visit '/parking_registrations/new'
    fill_in 'First name', with: 'Enka'
    fill_in 'Last name', with: 'Takahira'
    fill_in 'Email', with: email
    select 38, from: 'Spot number'
    click_button 'Register'
    expect(page).to have_content('Your spot has been registered')

    visit '/parking_registrations/new'

    expect(page).to have_selector("input[value='#{email}']")
  end

end