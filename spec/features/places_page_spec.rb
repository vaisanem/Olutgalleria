require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if many are returned by the API, are all shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("korso").and_return(
      [ Place.new( name:"Cupakka", id: 1 ), Place.new( name:"Bupi", id: 2 ),
        Place.new( name:"Olutta ja mennyttä", id: 3 )]
    )

    visit places_path
    fill_in('city', with: 'korso')
    click_button "Search"

    expect(page).to have_content "Cupakka"
    expect(page).to have_content "Bupi"
    expect(page).to have_content "Olutta ja mennyttä"
  end

  it "if none is returned by the API, information is displayed" do
    allow(BeermappingApi).to receive(:places_in).with("lahti").and_return(
      []
    )

    visit places_path
    fill_in('city', with: 'lahti')
    click_button "Search"

    expect(page).to have_content "No locations in lahti"
  end
end