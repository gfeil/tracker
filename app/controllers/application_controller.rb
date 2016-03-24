require 'visit_counter'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :record_visit

  private

  # Record the visit for the visitor. Sets a cookie for identification as needed.
  def record_visit
    unless (visit_key = cookies[:id])
      visit_key = SecureRandom.urlsafe_base64(16)
      cookies.permanent[:id] = visit_key
    end
    VisitCounter.record(visit_key)
  end

end
