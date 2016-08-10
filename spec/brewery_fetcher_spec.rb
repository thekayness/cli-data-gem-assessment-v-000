require_relative "spec_helper"

#change to Brewery_Fetcher
describe "Brewery_Fetcher" do

  #make example brewery request array
  let!(:brewery_query_array) {[{:name=>"Spiritus Fermenti", :street_address=>"220 Meeting Street", :phone=>"(401) 273-1999"},
                               {:name=>"Trinity Brewhouse", :street_address=>"186 Fountain Street", :phone=>"(401) 453-2337"},
                               {:name=>"Narragansett Brewing Company", :street_address =>"60 Ship Street", :phone=>"(401) 437-8970"}]}

  #make example brewery score hash
  let!(:brewery_trinity_score) {
    {
      :overall_score=>82.9,
      :selection=>4.31,
      :service=>4.00,
      :atmosphere=>4.13,
      :review_count=>4,
      :food=>3.94
    }
  }

  #make example brewery without score hash?
  let!(:gansett_score)   {
    {
      :overall_score=>82.9,
      :selection=>4.31,
      :service=>4.00,
      :atmosphere=>4.13,
      :review_count=>4,
      :food=>3.94,
      :fb_score=>3.6,
      :fb_count=>4
    }
  }

  #describe #query_api
  describe "#query_api" do
    it "is a class method that sends a location query to the beer mapping API and a returns an array of hashes in which each hash represents one brewery" do
      example_location_query = "http://beermapping.com/webservice/loccity/21110efff66df69d91ec3909c0a38eed/providence,ri"
      fetched_breweries = Brewery_Fetcher.query_api(example_location_query)
      expect(fetched_breweries).to be_a(Array)
      expect(fetched_breweries.first).to have_key(:street_address)
      expect(fetched_breweries.first).to have_key(:name)
      expect(fetched_breweries).to include(brewery_query_array[0], brewery_query_array[1], brewery_query_array[2])
    end
  end

  #describe #fetch_score_info
  describe "#fetch_score_info" do
    it "is a class method that scrapes sends a score query to the beer mapping API and returns a hash of rating scores given to an individual brewery" do
      #FIND OUT ID FOR TRINITY
      example_score_query = "http://beermapping.com/webservice/locscore/21110efff66df69d91ec3909c0a38eed/1341"
      fetched_score = Brewery_Fetcher.fetch_score_info(example_score_query)
      expect(fetched_score).to be_a(Hash)
      expect(fetched_score).to match(brewery_trinity_score)
    end
    #it can handle a brewery with no score info?
    it "can handle breweries with no scoring data" do
      #FIND OUT ID FOR
      no_score_example = "http://beermapping.com/webservice/locscore/21110efff66df69d91ec3909c0a38eed/15566"
      no_score_brewery = Brewery_Fetcher.fetch_score_info(no_score_example)
      #????maybe not a hash?
      expect(no_score_brewery).to be_a(Hash)
      expect(no_score_brewery).to match(gansett_score)
    end
  end
end
