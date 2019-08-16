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

  def monthly_transactions(filter_month)
    # bring in all transactions for an expense category
    all_transactions = transactions()
    # set new blank array to receive filtered month transactions
    monthly_transactions = []
    # get month and month dates
    month = filter_month
    start_date = Month.month_start(month)
    end_date = Month.month_end(month)
    # loop through all transactions to get a months transactions
    for transaction in all_transactions
      if (transaction.transaction_date >= start_date && transaction.transaction_date <= end_date)
        monthly_transactions.push(transaction)
      end
    end
    return monthly_transactions
  end

  def total_out(filter_month)
    # set outgoings for this expense category to zero
    outgoings = 0
    # loop through and add amount of each transaction to outgoings
    for transaction in monthly_transactions(filter_month)
      outgoings += transaction.amount
    end
    return outgoings
  end

  def budget_left(filter_month)
    return @budget - total_out(filter_month)
  end

  def self.total_budget()
    budgets = all()
    total_budget = 0
    for budget in budgets
      total_budget += budget.budget
    end
    return total_budget
  end

  def self.total_budget_left(filter_month)
    total_spent = Transaction.monthly_transactions(filter_month)
    return total_budget() - total_spent
  end

  def self.budget_alert(filter_month)
    budget_left = Expense.total_budget_left(filter_month).round(2)
    display_budget_left = (budget_left * -1).round(2)
    if budget_left < 0
      return "You are over your monthly budget by £#{display_budget_left}."
    elsif budget_left < 100
      return "You are close to budget limit, only £#{budget_left} left."
    else
      return "Budget okay so far, you have still got £#{budget_left}."
    end
  end

end
