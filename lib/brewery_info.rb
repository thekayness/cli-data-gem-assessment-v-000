#change to Brewery
class Brewery

  #change to reflect all brewery attributes
  attr_accessor :name, :street_address, :phone, :id, :overall_score, :selection, :service, :atmosphere, :review_count, :food

  @@all = []

  def initialize(brewery_hash)
    brewery_hash.each do |key, value|
      self.send(("#{key}="), value)
      @@all << self
    end
  end

  #change students_array to brewery_array
  def self.create_from_collection(brewery_array)
    brewery_array.each do |brewery_hash|
      #Brewery.new
      Brewery.new(brewery_hash)
    end
  end

  #change to add_brewery_info, score_hash
  def add_score_info(score_hash)
    score_hash.each do |key, value|
      self.send(("#{key}="), value)
    end
  end

  def self.all
    @@all
  end
end
