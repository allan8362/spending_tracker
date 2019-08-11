require_relative('../models/bank.rb')
require('pry-byebug')

# INDEX
get '/banks' do
  @banks = Bank.all()
  erb(:"banks/index")
end

# NEW
get '/banks/new' do
  @banks = Bank.all()
  erb(:"banks/new")
end

# CREATE
post '/banks' do
  bank_hash = params
  bank = Bank.new(bank_hash)
  bank.save()
  redirect "/banks"
end

# SHOW
get '/banks/:id' do
  id = params[:id].to_i()
  @bank = Bank.find(id)
  erb(:"banks/show")
end

# DELETE
post '/banks/:id/delete' do
  id = params[:id].to_i()
  bank = Bank.find(id)
  bank.delete()
  redirect "/banks"
end

# EDIT
get '/banks/:id/edit' do
  id = params[:id].to_i()
  @bank = Bank.find(id)
  erb(:"banks/edit")
end

# UPDATE
post '/banks/:id' do
  bank = Bank.new(params)
  bank.update()
  redirect '/banks'
end
