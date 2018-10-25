require 'rails_helper'

include Helpers

describe "Beer" do

  before :each do
    FactoryBot.create :user
    sign_in username: 'Pekka', password: 'Foobar1'
    @brewery = Brewery.create(name: "Whatever", year: 2017)
    visit new_beer_path
    select('Lager', from:'beer_style')
    select('Whatever', from:'beer_brewery_id')
  end

  it "with invalid name will not be saved" do
    fill_in('beer[name]', with: "")
    click_button('Create Beer')

    expect(Beer.count).to eq(0)
  end

  it "with valid name will be saved" do
    fill_in('beer[name]', with: "Olunen")

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
    expect(@brewery.beers.count).to eq(1)
  end

end