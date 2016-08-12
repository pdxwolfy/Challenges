# Pete Hanson
# Meetup challenge
# https://launchschool.com/gists/d6425cab

class Meetup
  FIRST_DAY = {
    first:  1,
    second: 8,
    third:  15,
    fourth: 22,
    last:   -7,
    teenth: 13
  }

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(weekday, schedule)
    check_day = "#{weekday}?"
    date = Date.new(@year, @month, FIRST_DAY[schedule])
    date += 1 until date.public_send(check_day)
    date
  end
end
