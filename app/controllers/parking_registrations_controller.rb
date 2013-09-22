class ParkingRegistrationsController < ApplicationController
  def new
    @parking_registration = ParkingRegistration.new
    @previous_registration = ParkingRegistration.find_by_id(session[:previous_registration_id])

    if @previous_registration.present?
      @parking_registration.email = @previous_registration.email
      @parking_registration.spot_number = @previous_registration.spot_number
    end
  end

  def create
    @parking_registration = ParkingRegistration.new(reg_params)
    if @parking_registration.park
      session[:previous_registration_id] = @parking_registration.id
      flash[:notice] = 'Your spot has been registered'
      redirect_to "/parking_registrations/#{@parking_registration.id}"
      else
      render :new
    end
  end

  def show
    @parking_registration = ParkingRegistration.find(params[:id])
  end

  protected
  def reg_params
    params.require(:parking_registration).permit(
      :first_name,
      :last_name,
      :email,
      :spot_number
      )
  end
end
