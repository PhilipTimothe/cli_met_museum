class Museum
    attr_accessor :name, :id

    @@all = []

    def initialize(name, id)
        @name = name 
        @id = id 
        @art_ids = []
        @@all << self 
    end 

    def add_art_ids(id)      #Might not need this at all. Double check code...
        @art_ids << id
        # id.museum = self
    end

    def art_ids
        @art_ids
    end

    def self.all 
        @@all 
    end 

    def self.find_by_id(id)
        @@all.find {|info| info.id == id}
    end


    

end 