require 'csv'

CSV.open("users.csv", "wb") do |csv|
  2000.times do
    csv << [rand(500000000000),rand(500000000000)]
  end
end
