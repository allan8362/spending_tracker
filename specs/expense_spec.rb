require('minitest/autorun')
require('minitest/rg')
require_relative('../models/expense.rb')

class TestExpense < MiniTest::Test

  def setup()
    @expense1 = Expense.new({
      "name" => "Food",
      "budget" => 300.01
      })
  end

  def test_has_name()
    assert_equal("Food", @expense1.name)
  end

  def test_has_budget()
    assert_equal(300.01, @expense1.budget)
  end

end
