require_relative('../models/income.rb')
require('pry-byebug')

# INDEX
get '/incomes' do
  @incomes = Income.all()
  @total_income = Income.total_income()
  erb(:"incomes/index")
end

# NEW
get '/incomes/new' do
  @incomes = Income.all()
  erb(:"incomes/new")
end

# CREATE
post '/incomes' do
  income_hash = params
  income = Income.new(income_hash)
  income.save()
  redirect "/incomes"
end

# DELETE
post '/incomes/:id/delete' do
  id = params[:id].to_i()
  income = Income.find(id)
  income.delete()
  redirect "/incomes"
end

# EDIT
get '/incomes/:id/edit' do
  id = params[:id].to_i()
  @income = Income.find(id)
  erb(:"incomes/edit")
end

# UPDATE
post '/incomes/:id' do
  income = Income.new(params)
  income.update()
  redirect '/incomes'
end

# SHOW
get '/incomes/:id' do
  id = params[:id].to_i()
  @income = Income.find(id)
  erb(:"incomes/show")
end
