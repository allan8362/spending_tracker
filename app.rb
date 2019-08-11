require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
also_reload('./models/*')

require_relative("./controllers/merchant_controller.rb")
require_relative("./controllers/expense_controller.rb")

get '/' do
  erb(:home)
end
