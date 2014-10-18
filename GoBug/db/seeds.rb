mich = User.create(username:"michelle", password:"password", password_confirmation:"password", first_name:"Michelle", last_name:"Chu", email:"michelle@gmail.com")
sarah = User.create(username:"sarah", password:"password", password_confirmation:"password", first_name:"Sarah", last_name:"Taurchini", email:"sarah@gmail.com")
nic = User.create(username:"nicolle", password:"password", password_confirmation:"password", first_name:"Nicolle", last_name:"Quintero", email:"nicolle@gmail.com")

houston = Location.create(name:"Houston TX USA")
austin = Location.create(name:"Austin TX USA")
dallas = Location.create(name:"Dallas TX USA")
dc = Location.create(name:"Washington DC USA")
charleston = Location.create(name:"Charleston SC USA")
ny = Location.create(name:"New York NY USA")
miami = Location.create(name: "Miami FL USA")
paris = Location.create(name:"Paris France")
london = Location.create(name:"London England")
rome = Location.create(name:"Rome Italy")
prague = Location.create(name:"Prague Czechoslovakia")
auckland = Location.create(name:"Auckland New Zealand")
leeds = Location.create(name:"Leeds England")
edinborough = Location.create(name:"Edinborough Scotland")
oahu = Location.create(name:"Oahu HI USA")
strassbourg = Location.create(name: "Strassbourg France")

food = Category.create(name:"Food")
housing = Category.create(name:"Housing")
transportation = Category.create(name:"Transportation")
shopping = Category.create(name:"Shopping")
activities = Category.create(name:"Activities")
misc = Category.create(name:"Miscellaneous")
