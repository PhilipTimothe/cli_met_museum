require 'pry'
class Cli

    def run
        puts "                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
        /yys/-.yyy/.-:+yyyyys:.  `-+yyyo----/oyyo                              
        ss-   `yyy:    `oyyy:       syy+      .+y                              
       `+     `yyy:     .yyy-       syy+   ``   :-                             
              `yyy:     .yyy-       syy+   -:    `                             
              `yyy:     .yyy:.......syy+.-/yo                                  
              `yyy:     .yyy:```````syy+`.:oy                                  
              `yyy:     .yyy-       syy+    /.                                 
              `yyy:     .yyy-       syy+     `   /`                            
              `yyy:     .yyy-       syy+       .os                             
            .-oyyy:  `.:syyys-`  `./yyyo....-/oyy/                             
            ``````    `````````   ```````````````                              
       ````               `````````````````````````                            
       .-oyyo.         `+yy/...-+yyyyo:..yyy/.-+yyo                            
         `yyyy.        +yyy:     `oy:    yyy:   `+y                            
         `ooyyy.      /-yyy:   .  `+     yyy:     :.                           
         `+`syys`    /.`yyy:   +.        yyy:                                  
         `+ `syys`  :- `yyy/-:oy/        yyy:                                  
         `+  `syyo .:  `yyy:`.:so        yyy:                                  
         `+   .yyyo/   `yyy:    +    `   yyy:                                  
         `+    .yyo    `yyy:    `   `+   yyy:                                  
         `o     -o     .yyy:       -s+   yyy/                                  
      `.:sy+-.      `.:syyy/----:+syy-   yyyy/-`                               
                                                     ".colorize(:light_blue)
        sleep 1
         welcome_guest
         Api.enter_museum
         main_functions
         second_functions
         third_functions
         exit_program
    end

    def main_functions
        print_all_art_departments
        print_selection_prompt
        @num_id = valid?(user_selection_input) #(validate selection id number)
    end

    def second_functions
        get_department_items(@num_id)
        print_second_selection_prompt
        @num = second_valid?(user_second_selection_input)
        details = get_artwork_details(@num)
        print_selection_details(details)
        print_continuation_prompt
        continuation_input
    end

    def third_functions
        explore_more?
        last_valid?
    end

    def exit_program  
        puts ""
        puts "Dont forget, art makes life fun!!!  See you next time  =)"
    end

    def welcome_guest
        puts "Welcome to one the worlds best collections of Art!!!"
        sleep 0.5
    end

    def print_all_art_departments
        puts ""
        Museum.all.each.with_index(1) { |departments, index| puts "#{index}. " + "#{departments.name}".colorize(:light_green) }
    end 

    def print_selection_prompt
        puts ""
        puts "What form of art would you like to explore today?"
        puts "Please enter a number, then press the enter key!"
    end 

    def user_selection_input
        gets.chomp
    end

    def valid?(num_id)
        num_id = num_id.to_i
            if num_id < 1 || num_id > Museum.all.size
                puts "So sorry, that is not a valid choice."
                puts "Please enter a valid number from list."
                sleep 1
                main_functions 
            end
        num_id    
    end

    def get_department_items(num_id) 
        art_dep_id = (Museum.all[num_id - 1]).id
        # binding.pry
        museum = Museum.find_by_id(art_dep_id)
            if museum.art_ids == []
                call = Api.department_by_id(art_dep_id)
                call.each {|info| museum.add_art_ids(info)}
            end
    end

    def print_second_selection_prompt
        sleep 1
        puts ""
        puts "Explore a random piece of art work!"
        puts "Enter a number between 1 and #{Department.all.size}, then press the enter key!"
    end

    def user_second_selection_input
        gets.strip 
    end

    def second_valid?(num)
        num = num.to_i
            if num < 1 || num > Department.all.size
                puts ""
                puts "So sorry, that is not a valid choice."
                # puts "Please enter a number between 1 and #{Department.all.size}, then press the enter key!"
                sleep 1
                second_functions
            end
        num
    end

    def get_artwork_details(input)
        art_dep_id = (Museum.all[@num_id - 1]).id
        museum = Museum.find_by_id(art_dep_id)
        artwork_id = museum.art_ids[input -1]
        department = Department.find_by_id(artwork_id)
            if department.art_details == []
                call = Api.artwork_by_id(artwork_id)
                department.add_art_details(call)
            end
        artwork_id
    end

    # def user_second_selection_input(num_id)
    #     input = gets.chomp.to_i
    #         if input < 1 || input > Department.all.size
    #             puts ""
    #             puts "So sorry, that is not a valid choice."
    #             puts "Please enter a number between 1 and #{Department.all.size}, then press the enter key!"
    #             sleep 1
    #             user_second_selection_input(num_id)
    #         end
    #     art_dep_id = (Museum.all[num_id - 1]).id
    #     museum = Museum.find_by_id(art_dep_id)
    #     artwork_id = museum.art_ids[input -1]
    #     # artwork_id = Department.all[input -1].art_id   #old code/ refactored into a save method
    #     department = Department.find_by_id(artwork_id)
    #         if department.art_details == []
    #             call = Api.artwork_by_id(artwork_id)
    #             department.add_art_details(call)
    #         end
    #         # binding.pry
    #     return artwork_id
    # end

    def print_selection_details(details)
        department = Department.find_by_id(details)
        sleep 1
        puts ""
        puts "Artist: #{department.art_details[0].artist}".colorize(:light_green)
        puts "Artwork: #{department.art_details[0].artwork}".colorize(:light_green)
        puts "Culture: #{department.art_details[0].culture}".colorize(:light_green)
        puts "Meduim: #{department.art_details[0].medium}".colorize(:light_green)
        puts "Origin Date: #{department.art_details[0].origin_date}".colorize(:light_green)
        puts "Region: #{department.art_details[0].region}".colorize(:light_green)
        puts ""
        puts "follow the artwork website link to intimately experience this work."
        puts "Artwork Website Url: #{department.art_details[0].url}".colorize(:light_red)
        puts ""
 #       binding.pry
    end

    def print_continuation_prompt
        puts "Press enter key to continue!"
    end

    def continuation_input
        input = gets.strip
            if input == "\n" 
                third_functions
            end
    end

    def explore_more?
        puts ""
        puts "Would like to explore more art from this category? Enter" + " y ".colorize(:red) + "/" + " n ".colorize(:red)
        puts ""
        puts "Want to select a different art category? Enter" + " m ".colorize(:red)
    end

    def last_valid?    
        input = gets.strip
            if input == "y" 
                second_functions
            elsif input == "n"
                exit_program
            elsif input == "m" 
                main_functions
            else
                puts "Sorry, we do not understand."
                third_functions
            end
    end













end