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
        # print_second_selection_prompt
        # user_second_selection_input (validate selection id number)
        # print_selection_details
        # print_continuation_prompt
        # explore_more?
    end

    def welcome_guest
        puts "Welcome to one the worlds best collections of Art!!!"
    end

    def print_all_art_departments
        Museum.all.each { |departments| puts "#{departments.id}. " + "#{departments.name}" }
    end 

    def print_selection_prompt
        puts "What form of art would you like to explore today?"
        puts "Please choose a number!"
    end 

    def user_selection_input
        gets.chomp
    end

    def valid?(num_id)
        num_id = num_id.to_i
        if num_id < 1 || num_id > Museum.all.size
            puts "So sorry, that is not a valid choice."
            puts "Please choose a valid number from list."
            sleep 2.5
             main_functions
        end
        num_id
    end

    def get_department_items(num_id) 
        Api.department_by_id(num_id)
    end















end