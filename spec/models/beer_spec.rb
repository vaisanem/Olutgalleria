require 'rails_helper'

RSpec.describe Beer, type: :model do
  
  it "is saved with name, style and brewery" do
    brewery = Brewery.create name: "Uusi", year: 2018
    beer = Beer.create name:"Iso", style:"Olut", brewery_id: brewery.id

    expect(beer.valid?).to be(true)
    expect(Beer.count).to eq(1)
  end

  it "is not saved without name" do
    beer = Beer.create style:"Olut"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "is not saved without style" do
    beer = Beer.create name:"Iso"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

end
