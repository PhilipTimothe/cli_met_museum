class Api
   ROOT_URL = 'https://collectionapi.metmuseum.org/public/collection/v1/'
   
    def self.enter_museum
        puts ""
        puts "Accessing Database.."
        response = RestClient.get(ROOT_URL + "departments")
        data = JSON.parse(response.body)
        data['departments'].each do |departments|
            name = departments['displayName']
            id = departments['departmentId']
            Museum.new(name, id)
   #     binding.pry 

        end
    end

    def self.department_by_id(art_dep_id)
        puts "Please wait.. Getting Art Identifcation.."
        response = RestClient.get(ROOT_URL + "search?departmentId=" + "#{art_dep_id}" + "&q=cat")
        data = JSON.parse(response.body)
        data['objectIDs'].each do |id| id 
            Department.new(id)
        end
    end

    def self.artwork_by_id(artwork_id)
        puts "Getting Art Details.."
        response = RestClient.get(ROOT_URL + "objects/" + "#{artwork_id}")
        data = JSON.parse(response.body)
        
        artwork = data["title"]
        artist = data["artistDisplayName"]
        culture = data["culture"]
        origin_date = data["objectDate"]
        medium = data["medium"]
        region = data["region"]
        url = data["objectURL"]

        Artwork.new(artwork, artist, culture, origin_date, medium, region, url)
    end






end 