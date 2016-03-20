class Visitor < ActiveRecord::Base
  validates_presence_of :visit_key, :starts_on, :ends_on
  before_validation :set_defaults

  scope :in_date_range, -> (start_date, end_date) { where(arel_table[:starts_on].lteq(end_date)).where(arel_table[:ends_on].gteq(start_date)) }

  class << self
    def unique_visitors_in_period(starts_on, ends_on)
      # SELECT DISTINCT COUNT(visit_key) FROM visitors WHERE visited_on BETWEEN starts_on AND ends_on
      in_date_range(starts_on, ends_on).select(:visit_key).distinct.count
    end

    def record_visit(visit_key, date = Date.today)
      if visitor = where(visit_key: visit_key, ends_on: [date.yesterday, date]).first
        visitor.update_attribute(:ends_on, date) unless visitor.ends_on == date
      else
        create(visit_key: visit_key, starts_on: date)
      end
    end
  end

  private

  def set_defaults
    self.starts_on ||= Date.today
    self.ends_on ||= Date.today
  end
end
