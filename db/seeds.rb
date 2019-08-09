require_relative("../models/bank.rb")
require_relative("../models/expense.rb")
require_relative("../models/merchant.rb")
# require_relative("../models/transaction.rb")
require("pry-byebug")

Merchant.delete_all()
Expense.delete_all()
Bank.delete_all()

merchant1 = Merchant.new({
  "name" => "Tesco",
  "tag" => "Food"
  })

merchant2 = Merchant.new({
  "name" => "Waterstones",
  "tag" => "Books"
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

expense2.budget = 120.00
expense2.update()

bank1 = Bank.new({
  "account_number" => 10124876,
  "name" => "RBS Main",
  "type" => "Current",
  "balance" => 512.22
  })

bank1.save()

bank1.name = "RBS Loyalty Account"
bank1.update()

binding.pry
nil
