require('minitest/autorun')
require('minitest/rg')
require_relative('../models/bank.rb')

class TestBank < MiniTest::Test

  def setup()
    @bank1 = Bank.new({
      "account_number" => 10124876,
      "name" => "Main",
      "type" => "Current",
      "balance" => 512.22
      })
  end

  def test_has_account_number()
    assert_equal(10124876, @bank1.account_number)
  end

  def test_has_name()
    assert_equal("Main", @bank1.name)
  end

  def test_has_type()
    assert_equal("Current", @bank1.type)
  end

  def test_has_balance()
    assert_equal(512.22, @bank1.balance)
  end

end
