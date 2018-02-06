class VintageBassController
   def initialize
      puts "Welcome to the vintage bass databass!"
      puts "Choose your brand (type a number)"
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
      input = gets.strip
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
      end
      brand
   end

   def modelChooser
      models = @b.scrape
      models.models.each.with_index(1) {|model, i|
         puts "#{i}. #{model.name} "
      }
      # modelI = "" 
      input = gets.strip
      # puts "You chose the #{@brand} #{models.models[input.to_i - 1].name}"



      #       @models.models.each.with_index(1) {|model,i|
      #    puts "#{i}. #{model.name} "
      # }
      models.models[input.to_i - 1].name
   end

   def yearChooser
      @instruments = @b.scrape_instruments
      @instruments.models.select{|m|m.name == @modelChoice}[0].instruments.each.with_index(1) {|inst, i| puts "#{i}. #{inst.name}"}
      input = gets.strip
      @instruments.models.select{|m|m.name == @modelChoice}[0].instruments[input.to_i - 1].name
   end

   def get_Description
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
         end
   end



end