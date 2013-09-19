class ParkingRegistration < ActiveRecord::Base
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :spot_number
  validates_presence_of :day_of

  validates_format_of :email,
    with: /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i

  # validates :spot_number, :uniqueness => true

  validates_uniqueness_of :spot_number,
    scope: :day_of

  validates_numericality_of :spot_number,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 60


  def self.spots
    (1..60).to_a
  end

  def park
    self.day_of = Date.today
    save
  end

  def neighbor
    below_spot = ParkingRegistration.where('spot_number = ?', spot_number - 1).first
    above_spot = ParkingRegistration.where('spot_number = ?', spot_number + 1).first
    if below_spot.present? && above_spot.present?
      "Your neighbors are #{below_spot.first_name} & #{above_spot.first_name}"
    elsif below_spot.present?
      "Your neighbor is #{below_spot.first_name}"
    elsif above_spot.present?
      "Your neighbor is #{above_spot.first_name}"
    else

      "Sad day, you have no neighbors"
    end


    # if ParkingRegistration.pluck(:spot_number).include?(above_spot)
    #   above_neighbor = ParkingRegistration.where(spot_number: above_spot)
    #   above_first = above_neighbor.pluck(:first_name).to_s
    # end
    # if ParkingRegistration.pluck(:spot_number).include?(below_spot)
    #   below_neighbor = ParkingRegistration.where(spot_number: below_spot)
    #   below_first = above_neighbor.pluck(:first_name).to_s
    # end

  end

end
