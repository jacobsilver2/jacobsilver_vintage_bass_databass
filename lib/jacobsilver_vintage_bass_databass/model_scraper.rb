# 1. We need a Model scraper class
# 2. We need to instantiate the brand of the chosen brand
# 3. We need to scrape the models of that brand, create new Model instances and add them to the brand
class ModelScraper
   attr_accessor :brand, :doc
   def initialize(brand)
      @brand = Brand.new
      @brand.name = brand
      @doc = Nokogiri::HTML(open("http://vintagebassworld.com/index.php#"))
   end

   def scrape
      models = []
      case @brand.name
         when "Rickenbacker"
            models = @doc.xpath('//*[@id="menu"]/ul/li[3]/ul/li[1]/ul').text.gsub(/\s+/, " ").strip.split(" ") 
            when "Fender"
               models = @doc.xpath('//*[@id="menu"]/ul/li[3]/ul/li[2]/ul').text.gsub(/\s+/, " ").strip.split(" ") 
               when "Gibson"
                  # Gibson models must be added manually because of the submenus and whitespace
                  # Add Thunderbird models manually
                  modelCount = 1
                  while modelCount <= 4
                     myxPath = "//*[@id=\'menu\']/ul/li[3]/ul/li[3]/ul/li[1]/ul/li[#{modelCount}]/a"
                     models << @doc.xpath("#{myxPath}").text
                     modelCount += 1
                  end
                  # Add EB models
                  modelCount = 1
                  while modelCount <= 10
                     myxPath = "//*[@id=\'menu\']/ul/li[3]/ul/li[3]/ul/li[2]/ul/li[#{modelCount}]/a"
                     models << @doc.xpath("#{myxPath}").text
                     modelCount += 1
                  end

                  # Add Grabber models
                  modelCount = 1
                     while modelCount <=2
                        myxPath = "//*[@id=\'menu\']/ul/li[3]/ul/li[3]/ul/li[3]/ul/li[#{modelCount}]/a"
                        models << @doc.xpath("#{myxPath}").text
                        modelCount += 1
                     end

                  # Add Ripper model, Les Paul, and V Bass models
                  modelCount = 4
                     while modelCount <= 6
                        myxPath = "//*[@id=\'menu\']/ul/li[3]/ul/li[3]/ul/li[#{modelCount}]/a"
                        models << @doc.xpath("#{myxPath}").text
                        modelCount += 1
                     end

                  # Add RD models
                  modelCount = 1
                     while modelCount <= 2
                        myxPath = "//*[@id=\'menu\']/ul/li[3]/ul/li[3]/ul/li[7]/ul/li[1]/a"
                        models << @doc.xpath("#{myxPath}").text
                        modelCount += 1
                     end


         when "Ampeg"
            #Ampeg models must be added a different way to account for whitespace issues.
            ampegModels = 1
            while ampegModels <= 8
               myxPath = "//*[@id=\'menu\']/ul/li[3]/ul/li[4]/ul/li[#{ampegModels}]/a"
               models << @doc.xpath("#{myxPath}").text
               ampegModels += 1
            end
         when "Musicman"
            models = @doc.xpath('//*[@id="menu"]/ul/li[3]/ul/li[5]/ul').text.gsub(/\s+/, " ").strip.split(" ") 
         end
         models.each { |model| 
            m = Model.new(model)
            @brand.add_model(m)
            }
         @brand
   end

   def scrape_instruments
      @brand.models.each { |model|
            instrumentDoc = Nokogiri::HTML(open("http://vintagebassworld.com/description.php?manufacturer=#{self.brand.name}&product=#{model.name}&year=0"))
            instruments = instrumentDoc.search(".clearfix ul").text.gsub(/\s+/, " ").strip.split(" ")
            instruments.each {|instrument|
                  i = Instrument.new(instrument)
                  instrumentDescDoc = Nokogiri::HTML(open("http://vintagebassworld.com/description.php?manufacturer=#{self.brand.name}&product=#{model.name}&year=#{instrument}"))
                  i.description = instrumentDescDoc.search(".desc_std").text.delete("\r\n\"")
                  i.description[0..36]=''
                  model.add_instrument(i)
            }
      }
      @brand
   end


end


