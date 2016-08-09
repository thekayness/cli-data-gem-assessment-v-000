require "spec_helper"

#change to Brewery_Fetcher
describe "Brewery_Fetcher" do

  #make example brewery request array
  let!(:brewery_query_array) {[{:name=>"Spiritus Fermenti", :street_address=>"220 Meeting Street", :phone=>"(401) 273-1999"},
                               {:name=>"Trinity Brewhouse", :street_address=>"186 Fountain Street", :phone=>"(401) 453-2337"},
                               {:name=>"Narragansett Brewing Company", :street_address =>"60 Ship Street", :phone="(401) 437-8970"}]}

  #make example brewery score hash
  let!(:brewery_trinity_score) {
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

  #make example brewery without score hash?
  let!(:gansett_score)   {
      :overall_score=>82.9,
      :selection=>4.31,
      :service=>4.00,
      :atmosphere=>4.13,
      :review_count=>4,
      :food=>3.94,
      :fb_score=>3.6,
      :fb_count = 4
    }
  }

  #describe #query_api
  describe "#scrape_index_page" do
    it "is a class method that scrapes the student index page and a returns an array of hashes in which each hash represents one student" do
      index_url = "./fixtures/student-site/index.html"
      scraped_students = Scraper.scrape_index_page(index_url)
      expect(scraped_students).to be_a(Array)
      expect(scraped_students.first).to have_key(:location)
      expect(scraped_students.first).to have_key(:name)
      expect(scraped_students).to include(student_index_array[0], student_index_array[1], student_index_array[2])
    end
  end

  #describe #fetch_score_info
  describe "#scrape_profile_page" do
    it "is a class method that scrapes a student's profile page and returns a hash of attributes describing an individual student" do
      profile_url = "./fixtures/student-site/students/joe-burgess.html"
      scraped_student = Scraper.scrape_profile_page(profile_url)
      expect(scraped_student).to be_a(Hash)
      expect(scraped_student).to match(student_joe_hash)
    end
    #it can handle a brewery with no added score info?
    it "can handle profile pages without all of the social links" do
      profile_url = "./fixtures/student-site/students/david-kim.html"
      scraped_student = Scraper.scrape_profile_page(profile_url)
      expect(scraped_student).to be_a(Hash)
      expect(scraped_student).to match(student_david_hash)
    end
  end
end
