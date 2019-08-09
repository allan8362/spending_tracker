require_relative('../db/sql_runner.rb')
require_relative('./transaction.rb')
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


end
