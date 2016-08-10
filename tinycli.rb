require_relative "lib/brewery_fetcher.rb"
require_relative "lib/brewery_info.rb"
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
  #get_location_query
  end

end

CommandLineInterface.new.run
