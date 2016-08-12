class Clock
  MINUTES_IN_DAY = 24 * 60
  SECONDS_PER_MINUTE = 60

  def initialize(hour, minute)
    @time = Time.new 2000, nil, nil, hour, minute
  end

  def self.at(hour, minute = 0)
    new hour, minute
  end

  def to_s
    @time.strftime '%H:%M'
  end

  def +(minutes) # rubocop:disable OpMethod ("other" is inappropriate name)
    make_new_clock minutes
  end

  def -(minutes) # rubocop:disable OpMethod ("other" is inappropriate name)
    make_new_clock(-minutes)
  end

  def ==(other)
    self.class == other.class && @time == other.time
  end

  protected #-------------------------------------------------------------

  attr_reader :time

  private #----------------------------------------------------------------

  def make_new_clock(delta_minutes)
    result_time = @time + minutes_to_seconds(delta_minutes)
    Clock.new result_time.hour, result_time.min
  end

  def minutes_to_seconds(minutes)
    # Limit adjustment to 24 hours to avoid daylight savings issues
    SECONDS_PER_MINUTE * (minutes % MINUTES_IN_DAY)
  end
end
