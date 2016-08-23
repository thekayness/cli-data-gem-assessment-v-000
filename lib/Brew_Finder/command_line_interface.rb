

class CommandLineInterface
#change this to base api query
  BASE_PATH = "http://beermapping.com/webservice/"
  KEY = "21110efff66df69d91ec3909c0a38eed"

#define welcome
    def welcome
      #first welcome user
      puts "\e[H\e[2J"
      puts <<-DOC
                        o©ºº©oo©oº°©oo____
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
      root_menu
    end


  def root_menu
    puts "Type 'search' to look for breweries, or 'exit' to quit."
    input = nil
    while input != "exit"
      input = gets.chomp
      case input
      when /search/
        return_search
        display_breweries
        score_menu
      when /exit/
        puts "Goodbye!"
        exit
      else
        puts "Sorry, what did you want to do?"
      end
    end
  end

  def return_search
    user_location_query = get_location_query
    #puts "#{user_location_query}"
    formatted_query = format_location_query(user_location_query)
    #puts "#{formatted_query}"
    get_breweries(formatted_query)
  end

  def score_menu
    puts "You can enter 'scores' if you would like to see how people have rated a brewery"
    puts "You can also enter 'search' to start a new search, or enter 'exit' to quit."
    input = nil
    while input != "exit"
      input = gets.chomp
      case input
      when /scores/
        return_scores
        end_menu
      when /search/
        return_search
        score_menu
      when /exit/
        puts "Goodbye!"
        exit
      else
        puts "Sorry, what did you want to do?"
      end
    end
  end

  def end_menu
    puts "Enter 'list' to show the previous search, 'search' to start a new search, or 'exit' to quit."
    input = nil
    while input != "exit"
      input = gets.chomp
      case input
      when /list/
        display_breweries
        score_menu
      when /search/
        return_search
        score_menu
      when /exit/
        puts "Goodbye!"
        exit
      else
        puts "Sorry, what did you want to do?"
      end
    end
  end

  def return_scores
    id = get_score_query
    formatted_scores = format_score_query(id)
    scores = get_brewery_score(formatted_scores)
    puts "#{scores}"
    scored_brewery = add_scores_to_brewery(id, scores)
    #puts "#{}"
    display_score(scored_brewery)
  end

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
    location_query = BASE_PATH + 'loccity/' + KEY + location.downcase
    location_query
  end

  def get_score_query
    puts "Which brewery would you like to learn more about?"
    begin
      puts "A valid brewery id is between 4 and 6 digits:"
      id = gets.chomp
    end until id.match(/(\d{4,6})/)
    id
  end

  def format_score_query(brewery_id)
    score_query = BASE_PATH + 'locscore/' + KEY + '/' + brewery_id
  end
#grab brewery objects from API
  def get_breweries(formatted_location)
    brewery_array = Brewery_Fetcher.query_api(formatted_location)
    #create instances of breweries from each brewery fetched
    Brewery.create_from_collection(brewery_array)
    #puts "#{brewery_array}"
  end

#take the requested brewery and add additional info
  def get_brewery_score(formatted_score)
    #take the brewery instance and give it more attributes
    scores = Brewery_Fetcher.fetch_score_info(formatted_score)
    scores
  end

  def add_scores_to_brewery(brewery_id, score_hash)
    if (score_hash == nil)
      scored_brewery = nil
    else
      scored_brewery = Brewery.all.detect{|brewery| brewery.id = brewery_id}
    end
  end

  def display_breweries
    Brewery.all.each do |brewery|
      print "Establishment: ".colorize(:light_yellow)
      puts "#{brewery.name}".colorize(:yellow)
      print "ID: ".colorize(:light_green)
      puts "#{brewery.id}".colorize(:green)
      puts "#{brewery.street_address}".colorize(:cyan)
      puts "#{brewery.phone}".colorize(:light_blue)
    end
  end

#display additional requested brewery info
  def display_score(scored_brewery)
    if (scored_brewery == nil)
      puts "No scores seem to be available for this brewery."
    else
      puts "#{scored_brewery.name}".colorize(:magenta)
      puts "Overall score: "
      print "#{scored_brewery.overall_score}".colorize(:light_yellow)
      puts "Selection: "
      print "#{scored_brewery.selection}".colorize(:light_yellow)
      puts "Service: "
      print "#{scored_brewery.service}".colorize(:light_yellow)
      puts "Atmosphere: "
      print "#{scored_brewery.atmosphere}".colorize(:light_yellow)
      puts "Number of reviews: "
      print"#{scored_brewery.review_count}".colorize(:light_yellow)
      puts "Food (if available): "
      print "#{scored_brewery.food}".colorize(:light_yellow)
    end
  end

end
