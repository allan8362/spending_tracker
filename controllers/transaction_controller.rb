require_relative('../models/transaction.rb')
require('pry-byebug')

# INDEX
get '/transactions' do
  @transactions = Transaction.all()
  @outgoings = Transaction.total_transactions()
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
get '/transactions/:id' do
  id = params[:id].to_i()
  @transaction = Transaction.find(id)
  erb(:"transactions/show")
end

# DELETE
post '/transactions/:id/delete' do
  id = params[:id].to_i()
  transaction = Transaction.find(id)
  transaction.delete()
  redirect "/transactions"
end

# EDIT
get '/transactions/:id/edit' do
  @banks = Bank.all()
  @merchants = Merchant.all()
  @expenses = Expense.all()
  id = params[:id].to_i()
  @transaction = Transaction.find(id)
  erb(:"transactions/edit")
end

# UPDATE
post '/transactions/:id' do
  transaction = Transaction.new(params)
  transaction.update()
  redirect '/transactions'
end
