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
    pet = SqlRunner.run( sql ).first
    @id = pet['id']
  end

  def store
    sql = "SELECT * FROM pet_stores WHERE id = #{@store_id}"
    store = SqlRunner.run(sql).first
    result = PetStore.new(store)
  end

  def self.find(id)
    sql = "SELECT * FROM pets WHERE id = #{id}" 
    pet = SqlRunner.run(sql).first
    return Pet.new(pet)
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
