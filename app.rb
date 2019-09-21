require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
also_reload('./models/*')

require_relative("./controllers/merchant_controller.rb")
require_relative("./controllers/expense_controller.rb")
require_relative("./controllers/bank_controller.rb")
require_relative("./controllers/transaction_controller.rb")
require_relative("./controllers/income_controller.rb")

get '/' do
  erb(:home)
end
