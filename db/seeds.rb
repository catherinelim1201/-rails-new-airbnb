# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

puts '====== Creating Users ======'
User.destroy_all
users = []

user1 = User.create!(
  first_name: "Catherine",
  last_name: "Lim",
  email: "catherine@gmail.com",
  password: "123456"
)

puts "====== Finished creating #{user1.first_name}. ======="

10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "password"
  )
  users << user

  puts "====== Finished creating #{user.first_name}. ======="
end

# ==============================================================================

puts "====== Creating listings ======"
Listing.destroy_all

5.times do
  listing = Listing.create!(
    name: Faker::Travel::TrainStation.name(region: 'united_states', type: 'metro'),
    details: "Welcome to #{Faker::Travel::TrainStation.name(region: 'united_states', type: 'metro')}! We have a big #{Faker::House.room} and we are sure that you will enjoy your stay with us!",
    location: Faker::Travel::Airport.name(size: 'large', region: 'united_states'),
    num_of_guests: Faker::Number.between(from: 1, to: 10),
    price_per_night: Faker::Number.decimal(l_digits: 2),
    host_id: user1.id
  )

  puts "====== Finished creating listing #{listing.name} for user1. ======"
end

25.times do
  listing = Listing.create!(
    name: Faker::Travel::TrainStation.name(region: 'united_states', type: 'metro'),
    details: "Welcome to #{Faker::Travel::TrainStation.name(region: 'united_states', type: 'metro')}! We have a big #{Faker::House.room} and we are sure that you will enjoy your stay with us!",
    location: Faker::Travel::Airport.name(size: 'large', region: 'united_states'),
    num_of_guests: Faker::Number.between(from: 1, to: 10),
    price_per_night: Faker::Number.decimal(l_digits: 2),
    host_id: users.sample.id
  )

  puts "====== Finished creating listing #{listing.name} for other users. ======"
end

# ==============================================================================

puts "====== Creating bookings ======"
Booking.destroy_all
user1 = User.first
users = User.where.not(id: user1.id)
user1_listings = Listing.where(host_id: user1.id)
other_listings = Listing.where.not(host_id: user1.id)

start = Date.today

puts "====== Creating 3 pending bookings for user1. ======"

3.times do
  start_date = start + rand(10).days
  booking = Booking.create!(
    guest: users.sample,
    status: "pending",
    listing: user1_listings.sample,
    start_date: start_date,
    end_date: start_date + rand(7).days,
    total_guests: rand(1..10)
  )

  puts "Finished creating #{booking.status} for user1. ======"
end

puts "====== Creating 3 declined bookings for user1. ======"

3.times do
  start_date = start + rand(10).days
  booking = Booking.create!(
    guest: users.sample,
    status: "declined",
    listing: user1_listings.sample,
    start_date: start_date,
    end_date: start_date + rand(7).days,
    total_guests: rand(1..10)
  )

  puts "Finished creating #{booking.status} for user1. ======"
end

puts "====== Creating 3 confirmed bookings for user1. ======"

3.times do
  start_date = start + rand(10).days
  booking = Booking.create!(
    guest: users.sample,
    status: "confirmed",
    listing: user1_listings.sample,
    start_date: start_date,
    end_date: start_date + rand(7).days,
    total_guests: rand(1..10)
  )

  puts "Finished creating #{booking.status} for user1. ======"
end

puts "====== Creating 3 pending bookings made by user1. ======"

3.times do
  start_date = start + rand(10).days
  booking = Booking.create!(
    guest: user1,
    status: "pending",
    listing: other_listings.sample,
    start_date: start_date,
    end_date: start_date + rand(7).days,
    total_guests: rand(1..10)
  )

  puts "Finished creating #{booking.status} made by user1. ======"
end

puts "====== Creating 3 declined bookings made by user1. ======"

3.times do
  start_date = start + rand(10).days
  booking = Booking.create!(
    guest: user1,
    status: "declined",
    listing: other_listings.sample,
    start_date: start_date,
    end_date: start_date + rand(7).days,
    total_guests: rand(1..10)
  )

  puts "Finished creating #{booking.status} made by user1. ======"
end

puts "====== Creating 3 confirmed bookings made by user1. ======"

3.times do
  start_date = start + rand(10).days
  booking = Booking.create!(
    guest: user1,
    status: "confirmed",
    listing: other_listings.sample,
    start_date: start_date,
    end_date: start_date + rand(7).days,
    total_guests: rand(1..10)
  )

  puts "Finished creating #{booking.status} made by user1. ======"
end

# ==============================================================================

# puts "====== Creating unavailable dates ======"
# UnavailableDate.destroy_all

# listings = Listing.first(5)

# listings.each do |listing|

# end
