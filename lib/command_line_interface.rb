require_relative "../lib/brewery_fetcher.rb"
require_relative "../lib/brewery_info.rb"
require 'nokogiri'
require 'colorize'

class CommandLineInterface
#change this to base api query
  BASE_PATH = "http://beermapping.com/webservice/"
  KEY = "21110efff66df69d91ec3909c0a38eed"

#what do we want to happen?
  def run
    #first welcome user
    puts "\e[H\e[2J"
    puts <<-DOC
                      o©ºº©oo©oº°©
                      /           \
                      |___________|____
                      |            |____)
                      |  WELCOME   |  | |
                      |            |  | |
                      |    TO      |  | |
                      |            |  | |
                      |  B R E W   |  | |
                      |            |__|_|
                      |   FINDER!  |____)
                      |____________|
                     (______________)
    DOC
    #first ask user for location query
    first_location_query = get_location_query
    format_location_query(first_location_query)
    #use results from get_query to get matching breweries
    #change to get_breweries
    get_breweries(location_query)
    #display_matching_breweries
    display_breweries
    #ask user for a brewery/breweries they want to learn more about
    first_score_query = get_score_query
    formatted_query = format_score_query(first_score_query)
    scores = get_brewery_score(formatted_query)
    add_scores_to_brewery(first_score_query, scores)
    #display brewery's additional info
    display_score
  end


#make a method that asks for a city/state to query & formats for api request
  #method name: get_query

  def get_location_query
    puts "Please enter the initials of a state you would like to search in:"
    begin
      puts "A valid state abbreviation is two letters."
      state = gets.chomp
    end until state.match(/^(?:(A[KLRZ]|C[AOT]|D[CE]|FL|GA|HI|I[ADLN]|K[SY]|LA|M[ADEINOST]|N[CDEHJMVY]|O[HKR]|P[AR]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY]))$/)

    puts "Now enter a city:"
    begin
      puts "Any city in #{state}"
      city = gets.chomp.downcase
    end until city.match(/^[a-zA-Z]+(?:[\s-][a-zA-Z]+)*$/)
    city_state_formatted = '/' + city + ',' + state
  end

  def format_location_query(location)
    location_query = BASE_PATH + 'loccity/' + KEY + location
  end

  def get_score_query
    puts "Which brewery would you like to learn more about?"
    until (id.match(/(\d{4,6})/))
      puts "A valid brewery id is between 4 and 6 digits:"
      id = gets.chomp
    end
    id
  end

  def format_score_query(brewery_id)
    score_query = BASE_PATH + 'locscore/' + KEY + '/' brewery_id
  end
#grab brewery objects from API
  def get_breweries(location_query)
    brewery_array = Brewery_Fetcher.query_api(location_query)
    #create instances of breweries from each brewery fetched
    Brewery.create_from_collection(brewery_array)
  end

#take the requested brewery and add additional info
  def get_brewery_score(score_query)
    #take the brewery instance and give it more attributes
    scores = Brewery_Fetcher.fetch_score_info(score_query)
  end

  def add_scores_to_brewery(brewery_id, score_hash)
    scored_brewery = Brewery.all.detect{|brewery| brewery.id = brewery_id}
    scored_brewery.add_score_info(score_hash)
    scored_brewery
  end

  def display_breweries
    Brewery.all.each do |brewery|
      puts "#{brewery.name}".colorize(:purple)
      puts "#{brewery.id}".colorize(:green)
      puts "#{brewery.street_address}".colorize(:blue)
      puts "#{brewery.phone}".colorize(:orange)
    end
  end

#display additional requested brewery info
  def display_score
    puts "#{scored_brewery.name}".colorize(:purple)
    puts "Overall score: #{scored_brewery.overall_score}".colorize(:red)
    puts "Selection: #{scored_brewery.selection}"
    puts "Service: #{scored_brewery.service}"
    puts "Atmosphere: #{atmosphere}"
    puts "Number of reviews: #{review_count}"
    puts "Food: #{food}"
  end

end
