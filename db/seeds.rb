# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'net/http'
require 'json'

url = "https://airport.api.aero/airport?user_key=" + ENV['SITA_USER_KEY'].to_s

res = Net::HTTP.get(URI.parse(url))
h_res = JSON.parse res[9..-2]

if h_res["success"]
  h_res['airports'].each do |airport|
    airport_cleaned = airport.except("terminal", "gate")
     Airport.create(airport_cleaned)
  end
end

