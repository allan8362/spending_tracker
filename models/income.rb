require_relative('../db/sql_runner.rb')
require('pry-byebug')

class Income

  attr_reader :id
  attr_accessor :name, :amount

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @amount = options['amount'].to_f
  end

  def save()
    sql = "INSERT INTO incomes (name, amount) VALUES ($1, $2) RETURNING id"
    values = [@name, @amount]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE incomes SET (name, amount) = ($1, $2) WHERE id = $3"
    values = [@name, @amount, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM incomes"
    results = SqlRunner.run(sql)
    return results.map {|income| Income.new(income)}
  end

  def self.find(id)
    sql = "SELECT * FROM incomes WHERE id = $1"
    values = [id]
    income = SqlRunner.run(sql, values)
    return Income.new(income.first())
  end

  def self.delete_all()
    sql = "DELETE FROM incomes"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM incomes WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

end
