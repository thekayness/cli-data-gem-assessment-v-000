require 'open-uri'
require 'nokogiri'
require 'pry'

class Brewery_Fetcher

  def self.query_api(api_query)
    returned_request = Nokogiri::HTML(open(api_query))

    breweries = []
    #we gotta use something called xpath?
    returned_request.xpath("//location").each do |location|
      brewery = {
      :name => location.xpath("child::name").text,
      :street_address => location.xpath("child::street").text,
      :phone => location.xpath("child::phone").text
      }
      #add brewery to breweries
      breweries << brewery
    end

    #return breweries
    return breweries
  end

#change to self.fetch_score_info
  def self.scrape_profile_page(profile_url)
    url = Nokogiri::HTML(open(profile_url))
    #brewery score profile
    student_profile = {}

    #change to reflect in depth score attributes
    #overall_score, selection, service, atmosphere, food, review_count, fb_score, fb_count
    links = url.css("div.social-icon-container a")
    links.each do |link|

      link_text = link.attribute("href").value
      if (link_text.include?("github"))
        student_profile[:github] = link_text

      elsif (link_text.include?("twitter"))
        student_profile[:twitter] = link_text

      elsif (link_text.include?("linkedin"))
        student_profile[:linkedin] = link_text

      else
        student_profile[:blog] = link_text

      end
    end

    student_profile[:bio] = url.css("div.bio-content p").text

    student_profile[:profile_quote] = url.css("div.profile-quote").text

    #return brewery score profile
    return student_profile

  end

end
