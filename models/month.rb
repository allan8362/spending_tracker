require('date')
require('pry-byebug')

class Month

  def self.month_start(this_month)

    this_year = Date.today().year()
    month = sprintf("%02d", this_month).to_i
    new_date = Date.new(this_year, month, 1)
    start_date = new_date.strftime("%Y-%m-%d")

  end

  def self.month_end(this_month)

    this_year = Date.today().year()
    month = sprintf("%02d", this_month).to_i
    new_date = Date.new(this_year, month, -1)
    end_date = new_date.strftime("%Y-%m-%d")

  end

  def self.month_names()
    return ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  end

end
