require_relative('../db/sql_runner.rb')
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

  def self.all()
    sql = "SELECT * FROM expenses"
    results = SqlRunner.run(sql)
    return results.map { |expense| Expense.new(expense)}
  end

  def self.delete_all()
    sql = "DELETE FROM expenses"
    SqlRunner.run(sql)
  end

end
