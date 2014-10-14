# gem install 'neo4j'
# gem install 'activemodel'
# gem install 'railties'

require 'neo4j'
require 'csv'

array_of_user_id_tuples = CSV.read("users.csv")
@invalid_relationships = []

Neo4j::Session.open(:server_db)

class User
  include Neo4j::ActiveNode
  property :user_id, type: Integer, constraint: :unique, index: :exact

  has_many :both, :friends, model_class: User
end

def invalid?(user_id_tuple)
  if user_id_tuple.first.index(/\D/) || user_id_tuple.last.index(/\D/)
    @invalid_relationships << user_id_tuple
    return true
  else
    return false
  end
end

def create_or_find_user(user_id)
  user = User.find_by(user_id: user_id)
  if user == nil
    user = User.create(user_id: user_id)
  end
  return user
end

def create_relationship(user_id_tuple)
  user1 = create_or_find_user(user_id_tuple.first.to_i)
  user2 = create_or_find_user(user_id_tuple.last.to_i)
  user1.friends << user2
end

array_of_user_id_tuples.each_with_index do |user_id_tuple, index|
  if invalid?(user_id_tuple)
    puts "Invalid relationship on line #{index+1} found!"
  else
    create_relationship(user_id_tuple)
  end
end

puts "Invalid relationships: "
puts @invalid_relationships.inspect
