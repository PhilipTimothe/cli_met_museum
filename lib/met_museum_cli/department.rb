class Department
    attr_accessor :museum, :art_id

    @@all = []

    def initialize(art_id)
        @art_id = art_id
        @art_details = []
        @@all << self 
    end 

    def add_art_details(id)
        @art_details << id
    end

    def art_details
        @art_details
    end

    def self.all 
        @@all 
    end 

    def self.find_by_id(art_id)
        @@all.find {|info| info.art_id == art_id}
    end

    

    

end 