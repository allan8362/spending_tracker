require('minitest/autorun')
require('minitest/rg')
require_relative('../models/income.rb')

class TestIncome < MiniTest::Test

  def setup()
    @income1 = Income.new({
      "name" => "Wages",
      "amount" => 800
      })
    end

    def test_has_name()
      assert_equal("Wages", @income1.name)
    end

    def test_has_amount()
      assert_equal(800, @income1.amount)
    end

  end
