require 'spec_helper'

describe ParkingRegistration do
  it { should have_valid(:first_name).when('Tina', 'Enka') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when('Durr', 'Takahira') }
  it { should_not have_valid(:last_name).when(nil, '') }

  it { should have_valid(:email).when('tinadurr@bellsouth.net', 'enkadurr@bellsouth.net') }
  it { should_not have_valid(:email).when(nil, '', '23146isd0') }

  it {should have_valid(:spot_number).when(3, 59) }
  it {should_not have_valid(:spot_number).when('', 0, 61) }

  it { should have_valid(:day_of).when(Date.today) }
  it { should_not have_valid(:day_of).when(nil, '') }
end

describe '.spots' do
  it 'includes numbers 1 to 60' do
    expect(ParkingRegistration.spots).to eql((1..60).to_a)
  end

  describe 'parking' do
    it 'parks the car for today' do
      registration = FactoryGirl.build(:parking_registration, day_of: nil)
      expect(registration.park).to eql(true)
      expect(registration.day_of).to eql(Date.today)
    end
  end
end