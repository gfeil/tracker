# A counter used to record unique visits on a daily, weekly, or monthly basis
class VisitCounter < Redis::Set
  DAILY   = :daily
  MONTHLY = :monthly
  WEEKLY  = :weekly

  attr_reader :period, :date

  class << self
    def daily(_date = Date.today)
      new(DAILY, _date)
    end

    def weekly(_date = Date.today)
      new(WEEKLY, _date)
    end

    def monthly(_date = Date.today)
      new(MONTHLY, _date)
    end

    def record(visit_key)
      daily.add(visit_key)
      weekly.add(visit_key)
      monthly.add(visit_key)
    end
  end

  def initialize(_period, _date)
    @period = _period
    @date   = start_date_for_period(_date)
    super(redis_key)
  end

  private

  def start_date_for_period(_date)
    case period
      when :monthly
        _date.beginning_of_month
      when :weekly
        _date.beginning_of_week
      else
        _date
    end
  end

  def redis_key
    ['VisitCounter', period, date.to_s]
  end

end