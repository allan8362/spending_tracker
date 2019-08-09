# require_relative("../models/bank.rb")
require_relative("../models/expense.rb")
require_relative("../models/merchant.rb")
# require_relative("../models/transaction.rb")
require("pry-byebug")

Merchant.delete_all()
Expense.delete_all()

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

binding.pry
nil
