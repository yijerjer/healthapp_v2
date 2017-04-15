# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

olympic_sport_array = ["Archery", "Athletics", "Badminton", "Basketball", "Beach Volleyball", "Boxing", "Canoe Slalom", "Canoe Sprint", "Cycling BMX", "Cycling Mountain Bike", "Cycling Road", "Cycling Track", "Diving", "Equestrian / Dressage", "Equestrian / Eventing", "Equestrian / Jumping", "Fencing", "Football", "Golf", "Gymnastics Artistic", "Gymnastics Rhythmic", "Handball", "Hockey", "Judo", "Modern Pentathlon", "Rowing", "Rugby", "Sailing", "Shooting", "Swimming", "Synchronized Swimming", "Table Tennis", "Taekwondo", "Tennis", "Trampoline", "Triathlon", "Volleyball", "Water Polo", "Weightlifting", "Wrestling Freestyle", "Wrestling Greco-Roman"]

ActiveRecord::Base.transaction do
  olympic_sport_array.each do |sport|
    Activity.create(name: sport)
  end
end