currency_codes = [
"AED",
"AFN",
"ALL",
"AMD",
"ANG",
"AOA",
"ARS",
"AUD",
"AWG",
"AZN",
"BAM",
"BBD",
"BDT",
"BGN",
"BHD",
"BIF",
"BMD",
"BND",
"BOB",
"BRL",
"BSD",
"BTC",
"BTN",
"BWP",
"BYR",
"BZD",
"CAD",
"CDF",
"CHF",
"CLF",
"CLP",
"CNY",
"COP",
"CRC",
"CUP",
"CVE",
"CZK",
"DJF",
"DKK",
"DOP",
"DZD",
"EEK",
"EGP",
"ERN",
"ETB",
"EUR",
"FJD",
"FKP",
"GBP",
"GEL",
"GGP",
"GHS",
"GIP",
"GMD",
"GNF",
"GTQ",
"GYD",
"HKD",
"HNL",
"HRK",
"HTG",
"HUF",
"IDR",
"ILS",
"IMP",
"INR",
"IQD",
"IRR",
"ISK",
"JEP",
"JMD",
"JOD",
"JPY",
"KES",
"KGS",
"KHR",
"KMF",
"KPW",
"KRW",
"KWD",
"KYD",
"KZT",
"LAK",
"LBP",
"LKR",
"LRD",
"LSL",
"LTL",
"LVL",
"LYD",
"MAD",
"MDL",
"MGA",
"MKD",
"MMK",
"MNT",
"MOP",
"MRO",
"MTL",
"MUR",
"MVR",
"MWK",
"MXN",
"MYR",
"MZN",
"NAD",
"NGN",
"NIO",
"NOK",
"NPR",
"NZD",
"OMR",
"PAB",
"PEN",
"PGK",
"PHP",
"PKR",
"PLN",
"PYG",
"QAR",
"RON",
"RSD",
"RUB",
"RWF",
"SAR",
"SBD",
"SCR",
"SDG",
"SEK",
"SGD",
"SHP",
"SLL",
"SOS",
"SRD",
"STD",
"SVC",
"SYP",
"SZL",
"THB",
"TJS",
"TMT",
"TND",
"TOP",
"TRY",
"TTD",
"TWD",
"TZS",
"UAH",
"UGX",
"USD",
"UYU",
"UZS",
"VEF",
"VND",
"VUV",
"WST",
"XAF",
"XAG",
"XAU",
"XCD",
"XDR",
"XOF",
"XPF",
"YER",
"ZAR",
"ZMK",
"ZMW",
"ZWL",
]

currency_codes.each {|code| Currency.create(code: code) }

mich = User.create(username:"michelle", password:"password", password_confirmation:"password", first_name:"Michelle", last_name:"Chu", email:"michelle@gmail.com")
sarah = User.create(username:"sarah", password:"password", password_confirmation:"password", first_name:"Sarah", last_name:"Taurchini", email:"sarah@gmail.com")
nic = User.create(username:"nicolle", password:"password", password_confirmation:"password", first_name:"Nicolle", last_name:"Quintero", email:"nicolle@gmail.com")

# houston = Location.create(name:"Houston TX USA")
# austin = Location.create(name:"Austin TX USA")
# dallas = Location.create(name:"Dallas TX USA")
# dc = Location.create(name:"Washington DC USA")
# charleston = Location.create(name:"Charleston SC USA")
# ny = Location.create(name:"New York NY USA")
# miami = Location.create(name: "Miami FL USA")
# paris = Location.create(name:"Paris France")
# london = Location.create(name:"London England")
# rome = Location.create(name:"Rome Italy")
# prague = Location.create(name:"Prague Czechoslovakia")
# auckland = Location.create(name:"Auckland New Zealand")
# leeds = Location.create(name:"Leeds England")
# edinborough = Location.create(name:"Edinborough Scotland")
# oahu = Location.create(name:"Oahu HI USA")
# strassbourg = Location.create(name: "Strassbourg France")
# hong_kong = Location.create(name: "Hong Kong")

food = Category.create(name:"Food")
housing = Category.create(name:"Housing")
transportation = Category.create(name:"Transportation")
shopping = Category.create(name:"Shopping")
activities = Category.create(name:"Activities")
misc = Category.create(name:"Miscellaneous")

trip = Trip.create(user: sarah, name: "Texas Vacation", budget: "100")
trip1 = Trip.create(user: nic, name: "Hong Kong Adventure", budget: "2000")
trip2 = Trip.create(user: nic, name: "Europe Dream", budget: "1500")

wishlist = Wishlist.create(user: mich, name: "Hong Kong Reunion", budget: "800")
wishlist1 = Wishlist.create(user: mich, name: "Texas Road Trip", budget: "300")
wishlist2 = Wishlist.create(user: sarah, name: "Eurotrip!", budget: "900")

trip.expenses.create(cost:30.50, currency_id: 150, usd_cost: 30.50, description:"Lunch at whattaburger", category: food, date: Time.now, location: houston)
trip.expenses.create(cost:112, currency_id: 150, usd_cost: 112, description:"Rodeo night show", category: activities, date: Time.now, location: houston)
trip.expenses.create(cost:400, currency_id: 10, usd_cost: 400, description:"Hotel stay at the Barn", category: housing, date: Time.now, location: austin)
trip2.expenses.create(cost:44.99, currency_id: 46, usd_cost: 57.41, description:"Sad face, happy face wall decor", category: shopping, date: Time.now, location: prague)
trip2.expenses.create(cost:432, currency_id: 46, usd_cost: 551.22, description:"Week long improv class", category: activities, date: Time.now, location: london)
trip1.expenses.create(cost:100, currency_id: 58, usd_cost: 12.89, description:"McDonalds dinner", category: food, date: Time.now, location: hong_kong)
trip1.expenses.create(cost:100, currency_id: 58, usd_cost: 12.89, description:"Egg Tarts", category: food, date: Time.now, location: hong_kong)

