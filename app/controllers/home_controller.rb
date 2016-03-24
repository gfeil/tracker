class HomeController < ApplicationController
  def index
    @visitors_today = VisitCounter.daily.count
    @visitors_weekly = VisitCounter.weekly.count
    @visitors_monthly = VisitCounter.monthly.count
  end
end
