class Department
    attr_accessor :art_id

    @@all = []

    def initialize(art_id)
        @art_id = art_id
        @@all << self 
    end 

    def self.all 
        @@all 
    end 

    

    

end 