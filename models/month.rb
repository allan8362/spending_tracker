require('date')
require('pry-byebug')

class Month

  def self.month_start(this_month)
    this_year = Date.today().year()
    # this is version using sprintf
    # start_date = Date.new(this_year, sprintf("%02d", this_month).to_i, 1).strftime("%Y-%m-%d")
    start_date = Date.new(this_year, this_month, 1).strftime("%Y-%m-%d")
  end

  def self.month_end(this_month)
    this_year = Date.today().year()
    # this is version using sprintf
    # end_date = Date.new(this_year, sprintf("%02d", this_month).to_i, -1).strftime("%Y-%m-%d")
    end_date = Date.new(this_year, this_month, -1).strftime("%Y-%m-%d")
  end

  def self.month_names()
    return ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  end

end
