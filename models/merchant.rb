require_relative('../db/sql_runner.rb')
require("pry-byebug")

class Merchant

  attr_reader :id
  attr_accessor :name, :tag

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @tag = options['tag']
  end

  def save()
    sql = "INSERT INTO merchants (name, tag) VALUES ($1, $2) RETURNING id"
    values = [@name, @tag]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM merchants"
    results = SqlRunner.run(sql)
    return results.map { |merchant| Merchant.new(merchant)}
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end
  
end
