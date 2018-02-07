class VintageBassController
   def initialize
      puts "Welcome to the vintage bass databass!"
      puts "Choose your brand (type a number), or type exit at any time to quit."
   end

   def call
      @brand = brandChooser
      puts "You chose #{@brand}"
      @b = ModelScraper.new(@brand)
      puts "What model of #{@brand} would you like to know more about?"
      @modelChoice = modelChooser
      puts "You chose the #{@brand} #{@modelChoice}."
      puts "Which year of the #{@brand} #{@modelChoice} are you interested in knowing more about?"
      @yearChoice = yearChooser
      puts "You chose the #{@yearChoice} #{@brand} #{@modelChoice}"
      description = get_Description
      puts "\n\n\n #{description}\n\n\n"
      goodbye
 
   end

   def brandChooser
      puts "1. Rickenbacker"
      puts "2. Fender"
      puts "3. Gibson"
      puts "4. Ampeg"
      puts "5. Musicman"
      brand = ""
      input = gets.downcase.strip
      case input
         when "1"
            brand = "Rickenbacker"
         when "2"
            brand = "Fender"
         when "3"
            brand = "Gibson"
         when "4"
            brand = "Ampeg"
         when "5"
            brand = "Musicman"
         when "exit"
            goodbye
         else
            puts "Not sure what you meant.  Please try again"
            brandChooser
      end
      brand
   end

   def modelChooser
      models = @b.scrape
      models.models.each.with_index(1) {|model, i|
         puts "#{i}. #{model.name} "
      }
      input = gets.strip
      if input == "exit"
         goodbye
      else
        models.models[input.to_i - 1].name
      end
   end

   def yearChooser
      #call scrape_instruments to add instruments (years) to Models
      @instruments = @b.scrape_instruments(@modelChoice)

      #display all the instruments (years)
      @instruments.models.select{|m|m.name == @modelChoice}[0].instruments.each.with_index(1) {|inst, i| puts "#{i}. #{inst.name}"}

      #get user input
      input = gets.strip
      if input == "exit"
         goodbye
      else
        # return the selected instrument (year)
         @instruments.models.select{|m|m.name == @modelChoice}[0].instruments[input.to_i - 1].name
      end
   end

   def get_Description
        #call the scrape method to return the description
       @instruments.models.select{|m|m.name == @modelChoice}[0].instruments.select{|inst| inst.name == @yearChoice}[0].description
   end

   def goodbye
      puts "Would you like to explore the databass again? (y/n)"
      input = gets.strip
      case input
         when "y"
            VintageBassController.new.call
         when "n"
            puts "Go practice.  Get outta here!"
            exit
         end
   end



end