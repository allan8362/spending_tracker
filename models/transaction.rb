require_relative('../db/sql_runner.rb')
require_relative('./expense.rb')
require_relative('./merchant.rb')
require_relative('./bank.rb')
require_relative('./month.rb')
require('date')
require('pry-byebug')

class Transaction

  attr_reader :id
  attr_accessor :transaction_date, :amount, :merchant_id, :transaction_desc, :bank_id, :expense_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @transaction_date = options['transaction_date']
    @amount = options['amount'].to_f()
    @merchant_id = options['merchant_id'].to_i()
    @transaction_desc = options['transaction_desc'].capitalize()
    @bank_id = options['bank_id'].to_i()
    @expense_id = options['expense_id'].to_i()
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

  def merchant()
    merchant = Merchant.find(@merchant_id)
    return merchant
  end

  def bank()
    bank = Bank.find(@bank_id)
    return bank
  end

  def self.total_transactions()
    # set total_trans to zero
    total_trans = 0
    # call in all banks
    banks = Bank.all()
    # loop through each bank
    for bank in banks
      # call function from banks for total_out
      # add to total_trans
      total_trans += bank.total_out()
    end
    # return total_trans
    return total_trans
  end

  def self.sorted_transactions(sort_col)
    transactions = all()
    case
    when sort_col == "Date-oldest-first"
      return transactions.sort_by { |transaction| transaction.transaction_date }
    when sort_col == "Date-newest-first"
      return transactions.sort { |transaction1, transaction2| transaction2.transaction_date <=> transaction1.transaction_date}
    when sort_col == "Expense"
      return transactions.sort_by { |transaction| transaction.expense.name }
    when sort_col == "Merchant"
      return transactions.sort_by { |transaction| transaction.merchant.name }
    when sort_col == "Amount_low-high"
      return transactions.sort_by { |transaction| transaction.amount }
    when sort_col == "Amount_high-low"
      return transactions.sort { |transaction1, transaction2| transaction2.amount <=> transaction1.amount }
    end

  end

  def self.filter_by_date(month)
    transactions = all()
    filtered_transactions = []

    start_date = Month.month_start(month)
    end_date = Month.month_end(month)

    for transaction in transactions
      if (transaction.transaction_date >= start_date && transaction.transaction_date <= end_date)
        filtered_transactions.push(transaction)
      end
    end
    return filtered_transactions
  end

  def self.monthly_transactions(month)
    total_trans = 0
    transactions = filter_by_date(month)
    for transaction in transactions
      total_trans += transaction.amount
    end
    return total_trans
  end


end
