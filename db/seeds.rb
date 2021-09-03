# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(email: "railsnewappnotificationaug2021@gmail.com",
             password: "pass_word",
             password_confirmation: "pass_word",
             role_names: ["","buyer"],
             admin: true,
             broker: false,
             buyer: true)

client = IEX::Api::Client.new(
  publishable_token: "#{ENV["PUBLISHABLE_TOKEN"]}",
  endpoint: 'https://sandbox.iexapis.com/v1'
)

MSFT = client.quote('MSFT')
Stock.create!(symbol: MSFT.symbol,
              name: MSFT.company_name,
              latest_price: MSFT.latest_price,
              latest_time: MSFT.latest_time,
              quantity: 1000 )

AAPL = client.quote('AAPL')
Stock.create!(symbol: AAPL.symbol,
              name: AAPL.company_name,
              latest_price: AAPL.latest_price,
              latest_time: AAPL.latest_time,
              quantity: 1000 )

AMZN = client.quote('AMZN')
Stock.create!(symbol:AMZN.symbol,
              name: AMZN.company_name,
              latest_price: AMZN.latest_price,
              latest_time: AMZN.latest_time,
              quantity: 1000 )
#NFLX
NFLX = client.quote('NFLX')
Stock.create!(symbol:NFLX.symbol,
              name: NFLX.company_name,
              latest_price: NFLX.latest_price,
              latest_time: NFLX.latest_time,
              quantity: 1000 )
#GOOGL
GOOGL = client.quote('GOOGL')
Stock.create!(symbol:GOOGL.symbol,
              name: GOOGL.company_name,
              latest_price: GOOGL.latest_price,
              latest_time: GOOGL.latest_time,
              quantity: 1000 )
#BRK.B
BRKB = client.quote('BRK.B')
Stock.create!(symbol:BRKB.symbol,
              name: BRKB.company_name,
              latest_price: BRKB.latest_price,
              latest_time: BRKB.latest_time,
              quantity: 1000 )
#JPM
JPM = client.quote('JPM')
Stock.create!(symbol:JPM.symbol,
              name: JPM.company_name,
              latest_price: JPM.latest_price,
              latest_time: JPM.latest_time,
              quantity: 1000 )
#JNJ
JNJ = client.quote('JNJ')
Stock.create!(symbol:JNJ.symbol,
              name: JNJ.company_name,
              latest_price: JNJ.latest_price,
              latest_time: JNJ.latest_time,
              quantity: 1000 )

#SPGI S&P Global Inc
SPGI = client.quote('SPGI')
Stock.create!(symbol:SPGI.symbol,
              name: SPGI.company_name,
              latest_price: SPGI.latest_price,
              latest_time: SPGI.latest_time,
              quantity: 1000 )

#CME Chicago Mercantile Exchange
CME = client.quote('CME')
Stock.create!(symbol:CME.symbol,
              name: CME.company_name,
              latest_price: CME.latest_price,
              latest_time: CME.latest_time,
              quantity: 1000 )
#binding.pry
