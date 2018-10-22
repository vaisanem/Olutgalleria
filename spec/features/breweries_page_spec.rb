require 'rails_helper'

describe "Breweries page" do
  it "should not have any before been created" do
    visit breweries_path
    expect(page).to have_content 'Breweries'
    expect(page).to have_content 'Active breweries 0'
    expect(page).to have_content 'Retired breweries 0'
  end

  describe "when breweries exist" do
    before :each do
      # jotta muuttuja näkyisi it-lohkoissa, tulee sen nimen alkaa @-merkillä
      @breweries = ["Koff", "Karjala", "Schlenkerla"]
      year = 1896
      @breweries.each do |brewery_name|
        FactoryBot.create(:brewery, name: brewery_name, year: year += 1, active: year % 2 == 0)
      end

      visit breweries_path
    end

    it "lists the existing breweries and their total number for both active and retired" do
    
      expect(page).to have_content "Active breweries #{Brewery.active.count}"
      expect(page).to have_content "Retired breweries #{Brewery.retired.count}"
    
      @breweries.each do |brewery_name|
        expect(page).to have_content brewery_name
      end
    end

    it "allows user to navigate to page of a Brewery" do
      click_link "Koff"
    
      expect(page).to have_content "Koff"
      expect(page).to have_content "Established in 1897"
    end
  end
end