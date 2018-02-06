class InvalidType < StandardError; end
class Brand
   attr_accessor :name, :models

   def initialize
      @models = []
   end

   def add_model(model)
      if !model.is_a?(Model)
         raise InvalidType, "Must be a Model object."
      else
         @models << model
      end
   end

   

end