class Artwork
    attr_accessor :artwork, :artist, :culture, :origin_date, :medium, :region, :url

    @@all = []

    def initialize(artwork, artist, culture, origin_date, medium, region, url)
        @artwork = artwork
        @artist = artist
        @culture = culture
        @origin_date = origin_date
        @medium = medium
        @region = region
        @url = url
        @@all << self 
    end 

    def self.all 
        @@all 
    end 






end