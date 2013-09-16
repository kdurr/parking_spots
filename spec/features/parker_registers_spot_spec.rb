require 'spec_helper'

feature %Q{'User registers a parking spot'} do
  # As a parker
  # I want to register my spot with my name
  # So that the parking company can identify my car
  #
  # Acceptance Criteria
  #
  # * I must specify a first name, last name, email, and parking spot number
  # * I must enter a vlid parking spot number (the lot has spots identified as numbers 1-60)
  # * I must enter a valid email

  scenario 'register a spot with identifying information' do
    visit '/parking'
    
  end
end