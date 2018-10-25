require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    @user = FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can log in with right credentials" do
      sign_in({ :username => @user.username, :password => @user.password })

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in({ :username => 'Pekka', :password => 'wrong' })

      expect(current_path).to eq(login_path)
      expect(page).to have_content 'Wrong credentials.'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')
  
    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  describe "who has rated beers" do
    before :each do
      create_beer_with_rating({ user: @user }, 'Lager', 22)
      visit user_path(@user)
    end

    it "has her and only her ratings displayed" do
      create_beer_with_rating({ user: @user }, 'IPA', 20)
      create_beer_with_rating({ user: FactoryBot.create(:user, username: "Pekko") }, 'Lager', 22)
      visit user_path(@user)

      expect(page).to have_content 'anonymous 22'
      expect(page).to have_content 'anonymous 20'
    end

    it "has favourite style" do
      expect(page).to have_content 'Favourite style: Lager'
    end

    it "has favourite brewery" do
      expect(page).to have_content 'Favourite brewery: anonymous'
    end
  end
end