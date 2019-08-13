require_relative('../models/expense.rb')
require('pry-byebug')

# INDEX
get '/expenses' do
  @month = Date.today().strftime("%m").to_i()
  @expenses = Expense.all()
  @outgoings = Transaction.monthly_transactions(@month)
  @total_budget = Expense.total_budget()
  @budget_left = Expense.total_budget_left(@month)
  @month_names = Month.month_names()
  erb(:"expenses/index")
end

get '/expenses/filtered' do
  @month = params[:month].to_i()
  @expenses = Expense.all()
  @outgoings = Transaction.monthly_transactions(@month)
  @total_budget = Expense.total_budget()
  @budget_left = Expense.total_budget_left(@month)
  @month_names = Month.month_names()
  erb(:"expenses/filtered")
end

# NEW
get '/expenses/new' do
  @expenses = Expense.all()
  erb(:"expenses/new")
end

# CREATE
post '/expenses' do
  expense_hash = params
  expense = Expense.new(expense_hash)
  expense.save()
  redirect "/expenses"
end

# SHOW
get '/expenses/:id' do
  id = params[:id].to_i()
  @expense = Expense.find(id)
  erb(:"expenses/show")
end

# DELETE
post '/expenses/:id/delete' do
  id = params[:id].to_i()
  expense = Expense.find(id)
  expense.delete()
  redirect "/expenses"
end

# EDIT
get '/expenses/:id/edit' do
  id = params[:id].to_i()
  @expense = Expense.find(id)
  erb(:"expenses/edit")
end

# UPDATE
post '/expenses/:id' do
  expense = Expense.new(params)
  expense.update()
  redirect '/expenses'
end
