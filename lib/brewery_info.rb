#change to Brewery
class Brewery

  #change to reflect all brewery attributes
  attr_accessor :name, :street_address, :phone, :id, :overall_score, :selection, :service, :atmosphere, :review_count, :food

  @@all = []

  def initialize(brewery_hash)
    #puts "#{brewery_hash}"
    brewery_hash.each do |key, value|
      #puts "#{key} #{value}"
      self.send(("#{key}="), value)
      #puts "#{self.phone}"
      @@all << self
    end

    #puts "#{@@all}"
  end

  #change students_array to brewery_array
  def self.create_from_collection(brewery_array)
    #puts "#{brewery_array}"
    brewery_array.each_with_index do |brewery_hash, index|
      #Brewery.new
      #puts "#{brewery_hash} #{index}"
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
