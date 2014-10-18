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

trip = Trip.create(user: sarah, name: "Texas Vacation", budget: "100")
trip1 = Trip.create(user: nic, name: "Texas Paradise", budget: "1000")

whattaburger = Expense.create(cost:30.50, currency_id: 10, description:"Lunch at whattaburger", category: food, trip: trip, date: Time.now, location: houston)
rodeo = Expense.create(cost:112, currency_id: 10, description:"Rodeo night show", category: activities, trip: trip, date: Time.now, location: houston)
barn = Expense.create(cost:400, currency_id: 10, description:"Hotel stay at the Barn", category: housing, trip: trip, date: Time.now, location: austin)

sad_happy_masks = Expense.create(cost:44.99, currency_id: 10, description:"Sad face, happy face wall decor", category: shopping, trip: trip1, date: Time.now, location: houston)
improv_class = Expense.create(cost:432, currency_id: 10, description:"Week long improv class", category: activities, trip: trip1, date: Time.now, location: dallas)
mcdonalds = Expense.create(cost:12, currency_id: 10, description:"McDonalds dinner", category: food, trip: trip1, date: Time.now, location: dallas)
