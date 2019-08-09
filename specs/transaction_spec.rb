require('minitest/autorun')
require('minitest/rg')
require_relative('../models/transaction.rb')

class TestTransaction < MiniTest::Test

  def setup()
    @transaction = Transaction.new({
      "date" => "25/07/2019",
      "amount" => 12.25,
      "merchant_id" => 2,
      "desc" => "new books",
      "bank_id" => 1,
      "expense_id" => 2
      })
  end

  def test_has_date()
    assert_equal("25/07/2019", @transaction.date)
  end

  def test_has_amount()
    assert_equal(12.25, @transaction.amount)
  end

  def test_has_merchant_id()
    assert_equal(2, @transaction.merchant_id)
  end

  def test_has_desc()
    assert_equal("new books", @transaction.desc)
  end

  def test_has_bank_id()
    assert_equal(1, @transaction.bank_id)
  end

  def test_has_expense_id()
    assert_equal(2, @transaction.expense_id)
  end

end
