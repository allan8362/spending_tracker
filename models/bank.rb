require_relative('../db/sql_runner.rb')

class Bank

  attr_reader :id
  attr_accessor :account_number, :name, :type, :balance

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @account_number = options['account_number'].to_i
    @name = options['name']
    @type = options['type']
    @balance = options['balance'].to_f
  end

  def save()
    sql = "INSERT INTO banks (account_number, name, type, balance) VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@account_number, @name, @type, @balance]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE banks SET (account_number, name, type, balance) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@account_number, @name, @type, @balance, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM banks"
    results = SqlRunner.run(sql)
    return results.map { |bank| Bank.new(bank)}
  end

  def self.find(id)
    sql = "SELECT * FROM banks WHERE id = $1"
    values = [id]
    bank = SqlRunner.run(sql, values)
    return Bank.new(bank.first())
  end

  def self.delete_all()
    sql = "DELETE FROM banks"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM banks WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

end
