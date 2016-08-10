require 'open-uri'
require 'nokogiri'

api_request = Nokogiri::XML(open("http://beermapping.com/webservice/loccity/21110efff66df69d91ec3909c0a38eed/providence,ri"))
breweries = []
#we gotta use something called xpath?
api_request.xpath("//location").each do |location|
  brewery = {
    :id => location.xpath("child::id").text.to_i,
  :name => location.xpath("child::name").text,
  :street_address => location.xpath("child::street").text,
  :phone => location.xpath("child::phone").text
  }
  #add brewery to breweries
  breweries << brewery
  #puts "#{brewery}"
end

returned_scores = Nokogiri::HTML(open("http://beermapping.com/webservice/locscore/21110efff66df69d91ec3909c0a38eed/1341"))
#brewery score profile
score_location = returned_scores.xpath("//location")
score_profile = {
#overall_score, selection, service, atmosphere, food, review_count, fb_score, fb_count
  :overall_score => score_location.xpath("child::overall").text.to_f,
  :selection => score_location.xpath("child::selection").text.to_f,
  :service => score_location.xpath("child::service").text.to_f,
  :atmosphere => score_location.xpath("child::atmosphere").text.to_f,
  :review_count => score_location.xpath("child::reviewcount").text.to_f,
  :food=>score_location.xpath("child::food").text.to_f
  }
#puts "#{returned_scores}"
puts"#{score_location}"
  puts "#{score_profile}"
