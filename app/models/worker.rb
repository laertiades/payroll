class Worker < ActiveRecord::Base
  has_many :checks
  validates :fname, :lname, :withhold, :hourrate, presence: true
  validates_inclusion_of :married, :in => [true, false]
  validates :withhold, :numericality => { :only_integer => true }
  validates :hourrate, :numericality => true

end
