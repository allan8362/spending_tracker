require_relative('../db/sql_runner.rb')
require_relative('./transaction.rb')
require_relative('./month.rb')
require("pry-byebug")

class Expense

  attr_reader :id
  attr_accessor :name, :budget

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @budget = options['budget'].to_f
  end

  def save()
    sql = "INSERT INTO expenses (name, budget) VALUES ($1, $2) RETURNING id"
    values = [@name, @budget]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE expenses SET (name, budget) = ($1, $2) WHERE id = $3"
    values = [@name, @budget, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM expenses"
    results = SqlRunner.run(sql)
    return results.map { |expense| Expense.new(expense)}
  end

  def self.find(id)
    sql = "SELECT * FROM expenses WHERE id = $1"
    values = [id]
    expense = SqlRunner.run(sql, values)
    return Expense.new(expense.first())
  end

  def self.delete_all()
    sql = "DELETE FROM expenses"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM expenses WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def transactions()
    sql = "SELECT * FROM transactions WHERE expense_id = $1"
    values = [id]
    transaction_data = SqlRunner.run(sql, values)
    return transaction_data.map { |transaction| Transaction.new(transaction)}
  end

  def total_out()
    # bring in all transactions for an expense category
    all_transactions = transactions()
    # set new blank array to receive filtered month transactions
    transactions = []
    # get month and month dates
    month = 8
    start_date = Month.month_start(month)
    end_date = Month.month_end(month)
    # loop through all transactions to get a months transactions
    for transaction in all_transactions
      if (transaction.transaction_date >= start_date && transaction.transaction_date <= end_date)
        transactions.push(transaction)
      end
    end
    # set outgoings for this expense category to zero
    outgoings = 0
    # loop through and add amount of each transaction to outgoings
    for transaction in transactions
      outgoings += transaction.amount
    end
    return outgoings
  end

  def budget_left()
    return @budget - total_out()
  end


end
