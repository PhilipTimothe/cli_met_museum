require 'pry'
class Cli

    def run
         welcome_guest
         Api.enter_museum
         main_functions
    end

    def main_functions
         print_all_art_departments
         print_selection_prompt
         num_id = valid?(user_selection_input) #(validate selection id number)
         get_department_items(num_id)
         print_second_selection_prompt
         input = valid_again?(user_second_selection_input) #(validate selection id number)
         get_artwork_info(input)
        # print_selection_details
        # print_continuation_prompt
        # explore_more?
    end

    def welcome_guest
        puts "Welcome to one the worlds best collections of Art!!!"
        sleep 1
    end

    def print_all_art_departments
        puts ""
        Museum.all.each.with_index(1) { |departments, index| puts "#{index}. " + "#{departments.name}" }
    end 

    def print_selection_prompt
        puts ""
        puts "What form of art would you like to explore today?"
        puts "Please enter a number, then hit the enter key!"
    end 

    def user_selection_input
        gets.chomp
    end

    def valid?(num_id)
        num_id = num_id.to_i
            if num_id < 1 || num_id > Museum.all.size
                puts "So sorry, that is not a valid choice."
                puts "Please enter a valid number from list."
                sleep 1.5
                main_functions
            end
        num_id
    end

    def get_department_items(num_id) 
        art_dep_id = (Museum.all[num_id - 1]).id
        Api.department_by_id(art_dep_id)
    end

    def print_second_selection_prompt
        sleep 1.5
        puts ""
        puts "Explore a random piece of art work!"
        puts "Enter a number between 1 and 10, then press the enter key!"
    end

    def user_second_selection_input
        gets.chomp
    end
    
    def valid_again?(input)
        input = input.to_i
            if input < 1 || input > 10
                puts ""
                puts "So sorry, that is not a valid choice."
                puts "Please enter a number between 1 and 10, then press the enter key!"
                sleep 1.5
                user_second_selection_input
            end
        input 
    end

    def get_artwork_info(input)
        artwork_id = Department.all[input -1].art_id
        Api.artwork_by_id(artwork_id)
    end














end