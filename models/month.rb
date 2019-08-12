require('date')

class Month

  def self.month_start(this_month)
    # this_month = Date.today().month()
    this_year = Date.today().year()

    case
    when this_month < 10
      start_date = "#{this_year}-0#{this_month}-01"
    else
      start_date = "#{this_year}-#{this_month}-01"
    end
  end

  def self.month_end(this_month)
    # this_month = Date.today().month()
    this_year = Date.today().year()
    case
    when this_month == 1, 3, 5, 7, 8
      end_date = "#{this_year}-0#{this_month}-31"
    when this_month == 2
      end_date = "#{this_year}-0#{this_month}-28"
    when this_month == 4, 6, 9, 11
      end_date = "#{this_year}-0#{this_month}-30"
    when this_month == 11
      end_date = "#{this_year}-#{this_month}-30"
    when this_month == 10, 12
      end_date = "#{this_year}-#{this_month}-31"
    end
  end

end
