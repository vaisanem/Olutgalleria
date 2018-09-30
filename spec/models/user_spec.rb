require 'rails_helper'

RSpec.describe User, type: :model do
  it "has username set correctly" do
    user = FactoryBot.create(:user)

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved with too short password" do
    user = User.create username:"Pekka", password:"No1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved with improper password" do
    user = User.create username:"Pekka", password:"secret1"

    expect(user.valid?).to be(false)

    user = User.create username:"Pekka", password:"Secret"

    expect(user.valid?).to be(false)

    expect(User.count).to eq(0)
  end

  describe "favourite beer" do
    let(:user){ FactoryBot.create(:user) }
  
    it "has method for determining it" do
      expect(user).to respond_to(:favourite_beer)
    end
  
    it "without ratings does not have one" do
      expect(user.favourite_beer).to eq(nil)
    end

    it "is the only rated one if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)
    
      expect(user.favourite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({ user: user }, "Lager", 20, 12)
      best = create_beer_with_rating({ user: user }, "Lager", 25)
    
      expect(user.favourite_beer).to eq(best)
    end
  end

  describe "favourite style" do
    let(:user){ FactoryBot.create(:user) }

    it "without ratings does not have one" do
      expect(user.favourite_style).to eq(nil)
    end

    it "is the only one if only one rating" do
      rating = FactoryBot.create(:rating, beer: FactoryBot.create(:beer), user: user)

      expect(user.favourite_style).to eq("Lager")
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({ user: user }, "Lager", 20, 12)
      create_beer_with_rating({ user: user }, "Porter", 20)
    
      expect(user.favourite_style).to eq("Porter")
    end
  end

  describe "favourite brewery" do
    let(:user){ FactoryBot.create(:user) }

    it "without ratings does not have one" do
      expect(user.favourite_brewery).to eq(nil)
    end

    it "is the only one if only one rating" do
      rating = FactoryBot.create(:rating, beer: FactoryBot.create(:beer), user: user)

      expect(user.favourite_brewery).to eq(rating.beer.brewery)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({ user: user }, "Lager", 20, 12)
      beer = FactoryBot.create(:beer, brewery: FactoryBot.create(:brewery, name: 'paras'))
      FactoryBot.create(:rating, score: 30, beer: beer, user: user)
    
      expect(user.favourite_brewery).to eq(beer.brewery)
    end
  end

  describe "with a proper password" do
    let(:user){ FactoryBot.create(:user) }
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    let(:test_beer) { FactoryBot.create(:beer) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, beer: test_beer, user: user)
      FactoryBot.create(:rating, score: 20, beer: test_beer, user: user)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
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
