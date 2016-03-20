class HomeController < ApplicationController
  def index
    today = Date.today
    @visitors_today = Visitor.unique_visitors_in_period(today, today)
    @visitors_weekly = Visitor.unique_visitors_in_period(today.beginning_of_week, today)
    @visitors_monthly = Visitor.unique_visitors_in_period(today.beginning_of_month, today)
  end
end
