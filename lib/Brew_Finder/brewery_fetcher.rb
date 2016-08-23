require 'open-uri'
require 'nokogiri'

class Brewery_Fetcher

  def self.query_api(api_query)
    returned_request = Nokogiri::HTML(open(api_query))
    breweries = []
    #we gotta use something called xpath?
    returned_request.xpath("//location").each do |location|
      brewery = {
        :id => location.xpath("child::id").text.to_i,
        :name => location.xpath("child::name").text,
        :street_address => location.xpath("child::street").text,
        :phone => location.xpath("child::phone").text
      }
      #add brewery to breweries
      breweries << brewery
    end

    return breweries
  end

#change to self.fetch_score_info
  def self.fetch_score_info(score_request)
    returned_scores = Nokogiri::HTML(open(score_request))
    #brewery score profile
    score_location = returned_scores.xpath("//location/*")

    if (score_location.xpath("//overall").text.to_i == 0)
      #puts "fetcher error"

      score_profile = nil
    else
      #puts "#{score_location.xpath("//overall").text}"
      score_profile = {

      #overall_score, selection, service, atmosphere, food, review_count
        :overall_score => score_location.xpath("//overall").text.to_f.round(1),
        :selection => score_location.xpath("//selection").text.to_f.round(2),
        :service => score_location.xpath("//service").text.to_f.round(2),
        :atmosphere => score_location.xpath("//atmosphere").text.to_f.round(2),
        :review_count => score_location.xpath("//reviewcount").text.to_i,
        :food=>score_location.xpath("//food").text.to_f.round(2)
        }
        score_profile
    end



  end

end
