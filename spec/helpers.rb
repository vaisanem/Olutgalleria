module Helpers

  def sign_in(credentials)
    visit login_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')   
  end

  def create_beer_with_rating(object, style, score)
    beer = FactoryBot.create(:beer, style: style)
    FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
    beer
  end

  def create_beers_with_many_ratings(object, style, *scores)
    scores.each do |score|
      create_beer_with_rating(object, style, score)
    end
  end

end