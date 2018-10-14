class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :beer_club

  def self.find_membership(user, beer_club)
    users_memberships = Membership.find_by(user_id: user.id)
    users_memberships.detect{ |m| m.beer_club_id == beer_club.id } if users_memberships.is_a?(Array)
    users_memberships
  end
end
