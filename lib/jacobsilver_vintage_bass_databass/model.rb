class InvalidType < StandardError; end
class Model
   attr_accessor :name, :instruments
   def initialize(name)
      @name = name
      @instruments = []
   end

   def add_instrument(instrument)
      if !instrument.is_a?(Instrument)
         raise InvalidType, "Must be an Instrument object."
      else
         @instruments << instrument
      end

   end
end