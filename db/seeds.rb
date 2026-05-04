
puts "Cleaning database"

Notification.destroy_all
Review.destroy_all
Registration.destroy_all
Event.destroy_all
Venue.destroy_all
Category.destroy_all
User.destroy_all


puts "Creating users"

admin = User.create!(name: "Main Admin", email: "admin@eventhub.com", password: "password123", role: "admin")

users = [
    {name: "Pepe Pepito", email: "pepe@miuandes.cl"},
    {name: "Pedro Ramirez",    email: "pedro@miuandes.cl"},
    {name: "Sofia Morales",    email: "sofia@miuandes.cl"},
    {name: "Andres Castillo",  email: "andres@miuandes.cl"},
    {name: "Valentina Torres", email: "valentina@miuandes.cl"},
    {name: "Diego Herrera",    email: "diego@miuandes.cl"},
    {name: "Camila Rojas",     email: "camila@miuandes.cl"},
    {name: "Sebastian Munoz",  email: "sebastian@miuandes.cl"},
].map do |attrs| User.create!(attrs.merge(password: "password123", role: "regular"))
end

pepe, pedro, sofia, andres, valentina, diego, camila, sebastian = users


puts "Creating categories"

categories = [ "Talk", "Wordshop", "Sports", "Social", "Study Group", "Arts & Culture"].map {|name| Category.create!(name: name)}

talk, workshop, sports, social, study, arts = categories


puts "creating venues"

venues = [
  { name: "Main Auditorium", address: "Central Campus", capacity: 300 },
  { name: "Conference Room A", address: "Los Andes Campus, Building A", capacity: 80 },
  { name: "University Gym", address: "Sports Area", capacity: 200 },
  { name: "Central Patio", address: "Main Campus Patio", capacity: 500 },
  { name: "Computer Lab", address: "Building B", capacity: 40 },
  { name: "Art Room", address: "Arts Faculty", capacity: 60 },
].map { |attrs| Venue.create!(attrs) }

auditorium, room, gym, patio, lab, art_room = venues


puts "Creating events"

now = Time.current

e_completed1 = Event.create!(
  title: "Introduction to Ruby on Rails",
  description: "Hands-on workshop to learn the basics of Rails.",
  start_date: now - 20.days,
  end_date: now - 20.days + 3.hours,
  capacity: 30,
  status: "completed",
  category: workshop,
  venue: lab,
  creator: pepe
)

e_completed2 = Event.create!(
  title: "Interfaculty Football Tournament",
  description: "Annual sports competition between faculties.",
  start_date: now - 15.days,
  end_date: now - 15.days + 6.hours,
  capacity: 100,
  status: "completed",
  category: sports,
  venue: gym,
  creator: pedro
)

e_completed3 = Event.create!(
  title: "Poetry and Music Night",
  description: "Cultural evening with live performances.",
  start_date: now - 10.days,
  end_date: now - 10.days + 2.hours,
  capacity: 60,
  status: "completed",
  category: arts,
  venue: art_room,
  creator: sofia
)

e_ongoing = Event.create!(
  title: "AI Hackathon",
  description: "24-hour AI development challenge.",
  start_date: now - 5.hours,
  end_date: now + 19.hours,
  capacity: 80,
  status: "ongoing",
  category: workshop,
  venue: room,
  creator: andres
)

e_published1 = Event.create!(
  title: "Cybersecurity Talk",
  description: "Learn about modern digital threats.",
  start_date: now + 3.days,
  end_date: now + 3.days + 2.hours,
  capacity: 150,
  status: "published",
  category: talk,
  venue: auditorium,
  creator: pepe
)

e_published2 = Event.create!(
  title: "Book Exchange Fair",
  description: "Bring and exchange used books.",
  start_date: now + 5.days,
  end_date: now + 5.days + 4.hours,
  capacity: 200,
  status: "published",
  category: social,
  venue: patio,
  creator: valentina
)

e_published3 = Event.create!(
  title: "Beginner Watercolor Workshop",
  description: "Learn basic watercolor techniques.",
  start_date: now + 7.days,
  end_date: now + 7.days + 3.hours,
  capacity: 20,
  status: "published",
  category: arts,
  venue: art_room,
  creator: sofia
)

e_published4 = Event.create!(
  title: "Calculus Study Group",
  description: "Collaborative session before exams.",
  start_date: now + 2.days,
  end_date: now + 2.days + 2.hours,
  capacity: 25,
  status: "published",
  category: study,
  venue: lab,
  creator: diego
)

e_draft = Event.create!(
  title: "Entrepreneurship Seminar",
  description: "Panel with startup founders.",
  start_date: now + 14.days,
  end_date: now + 14.days + 3.hours,
  capacity: 120,
  status: "draft",
  category: talk,
  venue: auditorium,
  creator: andres
)

e_cancelled = Event.create!(
  title: "Campus Running Marathon",
  description: "Cancelled due to maintenance.",
  start_date: now + 1.day,
  end_date: now + 1.day + 3.hours,
  capacity: 150,
  status: "cancelled",
  category: sports,
  venue: patio,
  creator: pedro
)

puts "Events created: #{Event.count}"

puts "Creating registrations"

Registration.create!(user: pedro, event: e_completed1, status: "confirmed")
Registration.create!(user: sofia, event: e_completed1, status: "confirmed")
Registration.create!(user: andres, event: e_completed1, status: "confirmed")
Registration.create!(user: valentina, event: e_completed1, status: "waiting_list")

Registration.create!(user: pepe, event:e_completed2, status: "confirmed")
Registration.create!(user: camila, event: e_completed2, status: "confirmed")
Registration.create!(user: diego, event: e_completed2, status: "confirmed")
Registration.create!(user: sebastian, event: e_completed2, status: "waiting_list")

Registration.create!(user: pepe, event: e_completed3, status: "confirmed")
Registration.create!(user: pedro, event: e_completed3, status: "confirmed")
Registration.create!(user: andres, event: e_completed3, status: "confirmed")

Registration.create!(user: pepe, event: e_ongoing, status: "confirmed")
Registration.create!(user: sofia, event: e_ongoing, status: "confirmed")
Registration.create!(user: valentina, event: e_ongoing, status: "confirmed")
Registration.create!(user: camila, event: e_ongoing, status: "waiting_list")

Registration.create!(user: pedro, event: e_published1, status: "confirmed")
Registration.create!(user: diego, event: e_published1, status: "confirmed")
Registration.create!(user: sebastian, event: e_published1, status: "confirmed")

Registration.create!(user: pepe, event: e_published2, status: "confirmed")
Registration.create!(user: andres, event: e_published2, status: "confirmed")

Registration.create!(user: pedro, event: e_published3, status: "confirmed")
Registration.create!(user: sofia, event: e_published3, status: "waiting_list")

Registration.create!(user: camila, event: e_published4, status: "confirmed")
Registration.create!(user: sebastian, event: e_published4, status: "confirmed")

puts "Registrations created: #{Registration.count}"

puts "Creating reviews"

Review.create!(user: pedro, event: e_completed1, rating: 5, comment: "Excellent workshop, very hands-on and practical!")
Review.create!(user: sofia, event: e_completed1, rating: 4, comment: "Great introduction to Rails, but could use more examples.")
Review.create!(user: andres, event: e_completed1, rating: 4, comment: "Good content, but the pace was a bit fast for beginners.")

Review.create!(user: pepe, event: e_completed2, rating: 5, comment: "Amazing tournament, great atmosphere and organization!")
Review.create!(user: camila, event: e_completed2, rating: 3, comment: "Fun event, but the facilities could have been better.")
Review.create!(user: diego, event: e_completed2, rating: 4, comment: "Good competition, but the scheduling was a bit rushed.")

Review.create!(user: pepe, event: e_completed3, rating: 5, comment: "Beautiful performances and a wonderful cultural experience!")
Review.create!(user: pedro, event: e_completed3, rating: 4, comment: "Great event, but the sound quality could have been better.")
Review.create!(user: andres, event: e_completed3, rating: 3, comment: "Enjoyable evening, but the venue was a bit cramped.")

puts "Reviews created: #{Review.count}"

puts "Creating notifications"
Notification.create!(user: pedro, title: "Registration Confirmed", message: "Your registration for 'Introduction to Ruby on Rails' has been confirmed.", notification_type: "registration")
Notification.create!(user: sofia, title: "Registration Confirmed", message: "Your registration for 'Introduction to Ruby on Rails' has been confirmed.", notification_type: "registration")
Notification.create!(user: valentina, title: "Waiting List Update", message: "You are on the waiting list for 'Introduction to Ruby on Rails'.", notification_type: "waitlist")
Notification.create!(user: pepe, title: "Registration Confirmed", message: "Your registration for 'Interfaculty Football Tournament' has been confirmed.", notification_type: "registration")
Notification.create!(user: camila, title: "Waiting List Update", message: "You are on the waiting list for 'Interfaculty Football Tournament'.", notification_type: "waitlist")
Notification.create!(user: andres, title: "Event Starting Soon", message: "The AI Hackathon starts in 30 minutes. Get ready!", notification_type: "reminder")
Notification.create!(user: sofia, title: "Event Starting Soon", message: "The AI Hackathon starts in 30 minutes. Get ready!", notification_type: "reminder")
Notification.create!(user: pedro, title: "New Event Published", message: "A new Cybersecurity Talk has been published. Register now!", notification_type: "event")
Notification.create!(user: diego, title: "New Event Published", message: "The Calculus Study Group is now open for registration.", notification_type: "event")
Notification.create!(user: pepe, title: "Event Cancelled", message: "Campus Running Marathon has been cancelled due to maintenance.", notification_type: "cancellation")
Notification.create!(user: andres, title: "Event Cancelled", message: "Campus Running Marathon has been cancelled due to maintenance.", notification_type: "cancellation")
Notification.create!(user: admin, title: "New Review Submitted", message: "Pedro Ramirez left a 5-star review for 'Introduction to Ruby on Rails'.", notification_type: "review")

puts "Notifications created: #{Notification.count}"
puts "Seeding complete!" 