require_relative('../db/sql_runner')

class Pet

  attr_reader :id
  attr_accessor :name, :type, :store_id

  def initialize(options)
    @id = options['id'].to_i if options['id'] != nil
    @name = options['name']
    @type = options['type']
    @store_id = options['store_id'].to_i
  end

  def save
    sql = "INSERT INTO pets (name, type, store_id) VALUES ( '#{@name}', '#{@type}', #{@store_id} ) RETURNING *"
    pet = SqlRunner.run(sql).first
    @id = pet['id']
  end

  def store
    sql = "SELECT * FROM pet_stores WHERE id = #{@store_id}"
    store = SqlRunner.run(sql).first
    result = PetStore.new(store)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM pets WHERE id = #{id}" 
    pet = SqlRunner.run(sql).first
    return Pet.new(pet)
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM pets WHERE name = '#{name}'" #?As it stands, have to enter argument (name) within single quotes. Any way round this? 
    pet = SqlRunner.run(sql).first
    return Pet.new(pet)
  end

  def self.mash(id_1, id_2)
    pet_1 = self.find_by_id(id_1)
    pet_2 = self.find_by_id(id_2)

    new_name_beginning = pet_1.name[0..2]
    new_name_end = pet_2.name[-3..-1]
    new_name = new_name_beginning + new_name_end

    new_type_beginning = pet_1.type[0..3]
    new_type_end = pet_2.type[-4..-1]
    new_type = new_type_beginning + new_type_end

    new_pet = Pet.new({'name' => "#{new_name}", 'type' => "#{new_type}", 'store_id' => pet_1.store_id})
    new_pet.save 
  end

  def self.list
    sql = "SELECT * FROM pets"
    list = SqlRunner.run(sql)
    return list.map { |pet| Pet.new(pet) }
  end
  
  def update
    sql = "UPDATE pets SET 
      name = '#{@name}',
      type = '#{@type}',
      store_id = #{@store_id}
      WHERE id = #{@id}"
    SqlRunner.run(sql).first
  end

  def delete
    sql = "DELETE FROM pets WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

end
