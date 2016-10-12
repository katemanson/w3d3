require_relative('../db/sql_runner')

class PetStore

  attr_reader :id
  attr_accessor :name, :address, :stock_type

  def initialize(options)
    @id = options['id'].to_i if options['id'] != nil # makes explicit that id doesn't exist on first calling PetStore.new (it's added in db); id = nil would become @id = 0 in Ruby
    @name = options['name']
    @address = options['address']
    @stock_type = options['stock_type']
  end

  def save
    sql = "INSERT INTO pet_stores (name, address, stock_type) VALUES ('#{@name}', '#{@address}', '#{@stock_type}') RETURNING *"
    pet_store = SqlRunner.run( sql ).first
    @id = pet_store['id']
  end

  def pet_list
    sql = "SELECT * FROM pets WHERE store_id = #{@id}"
    pets = SqlRunner.run(sql)
    return pets.map {|pet| Pet.new(pet)}
  end

  def self.find(id)
    sql = "SELECT * FROM pet_stores WHERE id = #{id}" 
    pet_store = SqlRunner.run(sql).first
    return PetStore.new(pet_store)
  end

  def self.list
    sql = "SELECT * FROM pet_stores"
    list = SqlRunner.run(sql)
    return list.map { |pet_store| PetStore.new(pet_store) }
  end

  def update
    sql = "UPDATE pet_stores SET 
      name = '#{@name}',
      address = '#{@address}',
      stock_type = '#{@stock_type}'
      WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM pet_stores WHERE id = #{@id}"
    if self.pet_list.length != 0
      return "All your pets will run away! You need to move all your pets before deleting a store!"
    else
      SqlRunner.run(sql)
    end
  end

end

