require_relative('./models/pet')
require_relative('./models/pet_store')
require('pry-byebug')

pet_emporium = PetStore.new({'name' => "Pet Emporium", 'address' => "No. 13 Trendy Side Alley", 'stock_type' => "Quirky"})
pet_emporium.save()
pets_r_us = PetStore.new({'name' => "Pets R Us", 'address' => "Middle of High Street", 'stock_type' => "Popular"})
pets_r_us.save()
zoo_planet = PetStore.new({'name' => "Zoo Planet", 'address' => "Out of Town", 'stock_type' => "Exotic"})
zoo_planet.save()
doomed_pets = PetStore.new({'name' => "Doomed Pets", 'address' => "Nowhere", 'stock_type' => "Empty"})
doomed_pets.save()

pet1 = Pet.new({'name' => "Ermyntrude", 'type' => "warthog", 'store_id' => zoo_planet.id})
pet1.save
pet2 = Pet.new({'name' => "Frank", 'type' => "goldfish", 'store_id' => pets_r_us.id})
pet2.save
pet3 = Pet.new({'name' => "Barry", 'type' => "iguana", 'store_id' => pet_emporium.id})
pet3.save

binding.pry
nil