require_relative("../models/bank.rb")
require_relative("../models/expense.rb")
require_relative("../models/merchant.rb")
require_relative("../models/transaction.rb")
require_relative("../models/income.rb")
require("pry-byebug")

Transaction.delete_all()
Merchant.delete_all()
Expense.delete_all()
Income.delete_all()
Bank.delete_all()

merchant1 = Merchant.new({
  "name" => "Tesco",
  "tag" => "Food"
  })

merchant2 = Merchant.new({
  "name" => "First Bus",
  "tag" => "Travel"
  })

  merchant1.save()
  merchant2.save()

  # merchant1.tag = "Groceries"
  # merchant1.update()

expense1 = Expense.new({
  "name" => "Food",
  "budget" => 300.01
  })

expense2 = Expense.new({
  "name" => "Travel",
  "budget" => 100.01
  })

expense1.save()
expense2.save()

# expense2.budget = 120.00
# expense2.update()
income1 = Income.new({
  "name" => "Wages",
  "amount" => 800
  })

income1.save()

bank1 = Bank.new({
  "account_number" => 10124876,
  "name" => "RBS Main",
  "type" => "Current",
  "balance" => 512.22
  })

bank1.save()

# bank1.name = "RBS Loyalty Account"
# bank1.update()

transaction1 = Transaction.new({
  "transaction_date" => "25/07/2019",
  "amount" => 12.25,
  "merchant_id" => merchant2.id,
  "transaction_desc" => "weekly bus ticket",
  "bank_id" => bank1.id,
  "expense_id" => expense2.id
  })

  transaction2 = Transaction.new({
    "transaction_date" => "1/08/2019",
    "amount" => 34.88,
    "merchant_id" => merchant1.id,
    "transaction_desc" => "food shopping",
    "bank_id" => bank1.id,
    "expense_id" => expense1.id
    })

transaction1.save()
transaction2.save()
transaction2.save()
transaction2.save()


binding.pry
nil
