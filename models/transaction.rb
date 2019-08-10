require_relative('../db/sql_runner.rb')
require_relative('./expense.rb')

class Transaction

  attr_reader :id
  attr_accessor :transaction_date, :amount, :merchant_id, :transaction_desc, :bank_id, :expense_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @transaction_date = options['transaction_date']
    @amount = options['amount'].to_f
    @merchant_id = options['merchant_id'].to_i
    @transaction_desc = options['transaction_desc']
    @bank_id = options['bank_id'].to_i
    @expense_id = options['expense_id'].to_i
  end

  def save()
    sql = "INSERT INTO transactions (transaction_date, amount, merchant_id, transaction_desc, bank_id, expense_id) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id"
    values = [@transaction_date, @amount, @merchant_id, @transaction_desc, @bank_id, @expense_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE transactions SET (transaction_date, amount, merchant_id, transaction_desc, bank_id, expense_id) = ($1, $2, $3, $4, $5, $6) WHERE id = $7"
    values = [@transaction_date, @amount, @merchant_id, @transaction_desc, @bank_id, @expense_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM transactions"
    results = SqlRunner.run(sql)
    return results.map { |transaction| Transaction.new(transaction)}
  end

  def self.find(id)
    sql = "SELECT * FROM transactions WHERE id = $1"
    values = [id]
    transaction = SqlRunner.run(sql, values)
    return Transaction.new(transaction.first())
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM transactions WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def expense()
    expense = Expense.find(@expense_id)
    return expense
  end

end
