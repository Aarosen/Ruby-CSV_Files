require 'faker'
require 'CSV'

class Person # creando la clase person para poder crear una persona con los 5 datos siguientes
  attr_accessor :first_name, :last_name, :email, :phone, :created_at

  def initialize(first_name, last_name, email, phone, created_at) # inicializando las 5 variables
    @first_name = first_name
    @last_name = last_name
    @email = email
    @phone = phone
    @created_at = created_at
  end
end
    
def people(numero) # creando metodo para meter valores aleatorios en las 5 variables utilizando 'Faker'
  arr = []
  (1..numero).each do |x|
    arr << Person.new(Faker::Name.first_name, Faker::Name.last_name, Faker::Internet.email, Faker::PhoneNumber.cell_phone, Faker::Date.backward)
  end
  arr 
end

class PersonWriter # creando una clase para poder imprimir en un documento 'CSV'
  def initialize(file, people)
    @file = file
    @people = people
  end
  

  def create_csv
    CSV.open(@file, "wb") do |csv|
      @people.each {|x| csv << [x.first_name, x.last_name, x.email, x.phone, x.created_at]}
    end
  end
end


#people = people(15)
#p people[0] = Person.new("Aaron", "Rosenzweig", "aaron_rosen@hamana.info", "(633)928-0183", "2016-11-29")

#person_writer = PersonWriter.new("people.csv", people)
#person_writer.create_csv

class PersonParser # creando una clase para poder tomar datos del documento 'CSV' y poniendo los datos dentro de un arreglo
  def initialize(file)
    @file = file
  end

  def people
    brr = []
    CSV.foreach (@file) do |row|
      brr << Person.new(row[0],row[1],row[2],row[3],row[4])
      #p brr << row
    end
    brr
  end
end

parser = PersonParser.new('people.csv')
people = parser.people
p people[0..9]