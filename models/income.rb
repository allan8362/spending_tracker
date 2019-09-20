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

  def self.all()
    sql = "SELECT * FROM incomes"
    results = SqlRunner.run(sql)
    return results.map {|income| Income.new(income)}
  end

  def self.delete_all()
    sql = "DELETE FROM incomes"
    SqlRunner.run(sql)
  end

end
