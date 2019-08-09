require('minitest/autorun')
require('minitest/rg')
require_relative('../models/merchant.rb')

class TestMerchant < MiniTest::Test

def setup()
@merchant = Merchant.new({"name" => "Asda", "tag" => "Food"})
end

def test_has_name()
assert_equal("Asda", @merchant.name)
end

def test_has_tag()
  assert_equal("Food", @merchant.tag)
end

end
