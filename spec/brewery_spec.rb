require "spec_helper"

#describe Brewery
describe "Brewery" do
  #make example brewery hash
  let!(:example_brewery_hash) {[{:name=>"Coastal Extreme Brewing Co.", :street_address=>"307 Oliphant Lane"},
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
       :food=>3.94,
       :fb_score=>3.6,
       :fb_count=>4
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
    it "uses the Scraper class to create new students with the correct name and location." do
      Student.class_variable_set(:@@all, [])
      Student.create_from_collection(student_index_array)
      expect(Student.class_variable_get(:@@all).first.name).to eq("Alex Patriquin")
    end
  end
  #describe add_brewery_info
  describe "#add_student_attributes" do
    it "uses the Scraper class to get a hash of a given students attributes and uses that hash to set additional attributes for that student." do
      student.add_student_attributes(student_hash)
      expect(student.bio).to eq("I was in southern California for college (sun and In-n-Out!), rural Oregon for high school (lived in a town with 1500 people and 3000+ cows), and Tokyo for elementary/middle school.")
      expect(student.blog).to eq("someone@blog.com")
      expect(student.linkedin).to eq("someone@linkedin.com")
      expect(student.profile_quote).to eq("\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi")
      expect(student.twitter).to eq("someone@twitter.com")
    end
  end

  #this can stay mostly the same, change Student to Brewery
  describe '.all' do
    it 'returns the class variable @@all' do
      Student.class_variable_set(:@@all, [])
      expect(Student.all).to match_array([])
    end
  end
end
