class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :beer_club

  scope :confirmed, -> { where confirmed: true }
  scope :not_confirmed, -> { where confirmed: [nil, false] }

  def self.find_membership(user, beer_club)
    users_memberships = Membership.where(user_id: user.id)
    users_memberships.detect{ |m| m.beer_club_id == beer_club.id }
  end
end
