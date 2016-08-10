require "spec_helper"

#describe Brewery
describe "Brewery" do
  #make example brewery hash
  let!(:example_brewery_array) {[{:name=>"Coastal Extreme Brewing Co.", :street_address=>"307 Oliphant Lane"},
 {:name=>"Coddington Brewing Co.", :street_address=>"210 Coddington Highway"},
 {:name=>"Sandy's Liquors", :street_address=>"717 Aquidneck Avenue"},
]}

 #make example score hash
 let!(:example_score_hash) {
   {
       :overall_score=>82.9,
       :selection=>4.31,
       :service=>4.00,
       :atmosphere=>4.13,
       :review_count=>4,
       :food=>3.94
     }
   }

  #create example brewery
  let!(:brewery) {Brewery.new({:name=>"Coastal Extreme Brewing Co.", :street_address=>"301 Oliphant Lane"})}

  after(:each) do
    Brewery.class_variable_set(:@@all, [])
  end
  describe "#new" do
    it "takes in an argument of a hash and sets that new brewery's attributes using the key/value pairs of that hash." do
      expect{Brewery.new({:name => "Coddington Brewing Co.", :street_address => "210 Coddington Highway"})}.to_not raise_error
      expect(brewery.name).to eq("Coastal Extreme Brewing Co.")
      expect(brewery.street_address).to eq("301 Oliphant Lane")
    end

    it "adds that new brewery to the Brewery class' collection of all existing breweries, stored in the `@@all` class variable." do
      expect(Brewery.class_variable_get(:@@all).first.name).to eq("Coastal Extreme Brewing Co.")
    end
  end

  describe ".create_from_collection" do
    it "uses the Brewery_Fetcher class to create new breweries with the correct name and location." do
      Brewery.class_variable_set(:@@all, [])
      Brewery.create_from_collection(example_brewery_array)
      expect(Brewery.class_variable_get(:@@all).first.name).to eq("Coastal Extreme Brewing Co.")
    end
  end
  #describe add_brewery_info
  describe "#add_score_info" do
    it "uses the Brewery_Fetcher class to get a hash of a given brewery's attributes and uses that hash to set additional attributes for that brweery." do
      brewery.add_score_info(example_score_hash)
      expect(brewery.overall_score).to eq(82.9)
      expect(brewery.selection).to eq(4.31)
      expect(brewery.service).to eq(4.00)
      expect(brewery.atmosphere).to eq(4.13)
      expect(brewery.review_count).to eq(4)
      expect(brewery.food).to eq(3.94)
    end
  end

  #this can stay mostly the same, change Student to Brewery
  describe '.all' do
    it 'returns the class variable @@all' do
      Brewery.class_variable_set(:@@all, [])
      expect(Brewery.all).to match_array([])
    end
  end
end
