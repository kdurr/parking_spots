class ParkingRegistrationsController < ApplicationController
  def new
    @parking_registration = ParkingRegistration.new
  end
end
