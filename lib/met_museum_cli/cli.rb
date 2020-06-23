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
        
        input = ""
        while input != "n"
        input = gets.strip
            case input
                when "y"
                    main_functions
                when "n"
                    puts ""
                    puts "Dont forget, art makes life fun!!!  See you next time  =)"  
                    break
                when "m"
                    continue_helper(input)
                    break 
                else
                    puts "Sorry, we do not understand."
                    explore_more?
            end
        end
    end

#----------------------------------------------------------------------------------------------------program functions    

    def main_functions
        print_all_art_departments
        print_selection_prompt
        input = gets.chomp 
        if valid?(input) 
            @art_dep_choice = input.to_i
            get_department_items
            # print_second_selection_prompt
            # input = gets.chomp
            continue_helper(input)
            # if second_valid?(input)
            #     @artwork_choice = input.to_i
            #     details = get_artwork_details
            #     print_selection_details(details)
            #     explore_more?
            # else
            #     puts ""
            #     puts "So sorry, that is not a valid choice."
            #     puts "Lets start again!"
            #     sleep 1
            #     main_functions
            # end
        else
            puts "So sorry, that is not a valid choice."
            puts "Please enter a valid number from list."
            sleep 0.5
            main_functions
        end
    end

 #------------------------------------------------------------------------------------------------active methods 
 
 
    def welcome_guest
        puts "Welcome to one the worlds best collections of Art!!!"
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

    def valid?(input)
        return false if input == ""   
        !(input.to_i < 1 || input.to_i > Museum.all.size)
    end
    
    def get_department_items 
        art_dep_id = (Museum.all[@art_dep_choice - 1]).id
        museum = Museum.find_by_id(art_dep_id)
        if museum.art_ids == []
            call = Api.department_by_id(art_dep_id)
            call.each {|info| museum.add_art_ids(info)}
        end
    end
    
    def print_second_selection_prompt
        sleep 1
        art_dep_id = (Museum.all[@art_dep_choice - 1]).id
        museum = Museum.find_by_id(art_dep_id)
        puts ""
        puts "Explore a random piece of art work!"
        puts "Enter a number between 1 and #{museum.art_ids.size}, then press the enter key!"
    end
    
    def second_valid?(input)
        art_dep_id = (Museum.all[@art_dep_choice - 1]).id
        museum = Museum.find_by_id(art_dep_id)
        return false if input == ""   
        !(input.to_i < 1 || input.to_i > museum.art_ids.size)
    end

    def get_artwork_details
        art_dep_id = (Museum.all[@art_dep_choice - 1]).id
        museum = Museum.find_by_id(art_dep_id)
        artwork_id = museum.art_ids[@artwork_choice - 1]
        department = Department.find_by_id(artwork_id)
        if department.art_details == []
            call = Api.artwork_by_id(artwork_id)
            department.add_art_details(call)
        end
        artwork_id
    end
    
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
    end
    
    def explore_more?
        puts ""
        puts "Would like to explore more art? Enter" + " y ".colorize(:red) + "/" + " n ".colorize(:red)
        puts ""
        puts "Enter" + "m" + " to explore another random art piece"
    end

#------------------------------------------------------------------------------------------- CLI Assessement Addition    

    def continue_helper(input)
        print_second_selection_prompt
        input = gets.chomp
            if second_valid?(input)
                @artwork_choice = input.to_i
                details = get_artwork_details
                print_selection_details(details)
                explore_more?
            else
                puts ""
                puts "So sorry, that is not a valid choice."
                puts "Lets start again!"
                sleep 1
                main_functions
            end
    end
    







    



end