class Listing < ApplicationRecord
  has_many :bookings, dependent: :nullify
  has_many :unavailable_dates, dependent: :nullify


end
