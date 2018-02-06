# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application
I've created the class #vintage_bass_controller, which is essentially the CLI for the gem.  When it is initially called by the bin file, it sends a welcome message, and asks the user which brand of bass they are interested in.  The user then chooses the brand and the app continues all the way down to the individual details of whatever year of instrument the user chooses.
- [x] Pull data from an external source
This gem gets its data from http://vintagebassworld.com . It pulls data from that website along each step of the search process.
- [x] Implement both list and detail views
The gem begins with a list of brands.  From there it lists models of the brand the user chooses.  After that, it lists every year the model was made.  Once the user chooses the year they are interested in, the gem displays details about that particular year of bass.
