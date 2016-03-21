# Model for recording visitor activity in the database.
class Visitor < ActiveRecord::Base
  validates_presence_of :visit_key, :starts_on, :ends_on
  before_validation :set_defaults

  scope :in_date_range, -> (start_date, end_date) { where(arel_table[:starts_on].lteq(end_date)).where(arel_table[:ends_on].gteq(start_date)) }

  class << self
    # Count the number of unique visitor for the given calendar period, inclusive of dates
    # @param [Date] starts_on starting date
    # @param [Date] ends_on ending date
    # @return [Integer] number of unique visitors for the time period
    def unique_visitors_in_period(starts_on, ends_on)
      in_date_range(starts_on, ends_on).select(:visit_key).distinct.count
    end

    # Record a visit.
    # If an existing instance is found for the given visit_key with an ends_on date set to the visit date or the
    # previous day, the existing record is updated with the end_date set to the visit date (if necessary).
    # If no such record exists, a new Visitor instance is created.
    # @param [String] visit_key identifier for the visitor
    # @param [Date] date date of visit (Date.today)
    # @return [Visitor] new or updated record for visitor
    def record_visit(visit_key, date = Date.today)
      if visitor = where(visit_key: visit_key, ends_on: [date.yesterday, date]).first
        visitor.update_attribute(:ends_on, date) unless visitor.ends_on == date
        visitor
      else
        create(visit_key: visit_key, starts_on: date)
      end
    end
  end

  private

  def set_defaults
    self.starts_on ||= Date.today
    self.ends_on   ||= Date.today
  end
end
