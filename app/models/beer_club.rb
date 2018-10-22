class BeerClub < ApplicationRecord
  has_many :memberships, -> { where confirmed: true }
  has_many :applications, -> { where confirmed: [nil, false] }, class_name: "Membership"
  has_many :members, through: :memberships, source: :user
  has_many :applicants, through: :applications, source: :user
end
