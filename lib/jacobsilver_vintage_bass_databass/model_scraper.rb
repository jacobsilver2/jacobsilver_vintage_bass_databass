# 1. We need a Model scraper class
# 2. We need to instantiate the brand of the chosen brand
# 3. We need to scrape the models of that brand, create new Model instances and add them to the brand
class ModelScraper
   attr_accessor :brand, :doc
   def initialize(brand)
      @brand = Brand.new
      @brand.name = brand
      @doc = Nokogiri::HTML(open("http://vintagebassworld.com/index.php#"))
      # scrape
      # scrape_instruments
   end

   def scrape
      case @brand.name
         when "Rickenbacker"
            models = @doc.xpath('//*[@id="menu"]/ul/li[3]/ul/li[1]/ul').text.gsub(/\s+/, " ").strip.split(" ") 
         when "Fender"
            models = @doc.xpath('//*[@id="menu"]/ul/li[3]/ul/li[2]/ul').text.gsub(/\s+/, " ").strip.split(" ") 
         when "Gibson"
            models = @doc.xpath('//*[@id="menu"]/ul/li[3]/ul/li[3]/ul').text.gsub(/\s+/, " ").strip.split(" ") 
         when "Ampeg"
            models = @doc.xpath('//*[@id="menu"]/ul/li[3]/ul/li[4]/ul').text.gsub(/\s+/, " ").strip.split(" ") 
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


