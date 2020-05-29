class Api
   ROOT_URL = 'https://collectionapi.metmuseum.org/public/collection/v1/'
   
    def self.enter_museum
        response = RestClient.get(ROOT_URL + "departments")
        data = JSON.parse(response.body)
        
        data['departments'].each do |departments|
            name = departments['displayName']
            id = departments['departmentId']
            Museum.new(name, id)
   #     binding.pry 

        end
    end

    def self.department_by_id(num_id)
        response = RestClient.get(ROOT_URL + "search?departmentId=" + "#{num_id}" + "&q=cat")
        data = JSON.parse(response.body)
        data['objectIDs'].each do |id| id 
            Department.new(id)
        end
        binding.pry 
    end










end 