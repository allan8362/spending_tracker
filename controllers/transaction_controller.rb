require_relative('../models/transaction.rb')
require('pry-byebug')

# INDEX
get '/transactions' do
  @transactions = Transaction.all()
  erb(:"transactions/index")
end

# NEW
get '/transactions/new' do
  @transactions = Transaction.all()
  @banks = Bank.all()
  @merchants = Merchant.all()
  @expenses = Expense.all()
  erb(:"transactions/new")
end

# CREATE
post '/transactions' do
  transaction_hash = params
  transaction = Transaction.new(transaction_hash)
  transaction.save()
  redirect "/transactions"
end

# SHOW


# DELETE


# EDIT


# UPDATE
