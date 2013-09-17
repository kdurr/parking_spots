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

  # def vacant
  #   # return true unless self.spot_number.nil?
  #   ParkingRegistration.pluck(:spot_number).each do |spot|
  #     if self.spot_number == spot
  #       return false
  #     else
  #       return true
  #     end
  #   end
  # end

end
