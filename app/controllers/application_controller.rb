class ApplicationController < ActionController::Base
  before_filter :authenticate_for_internal
  protect_from_forgery

  def authenticate_for_internal
    authenticate_or_request_with_http_basic do |username, password|
      username == 'bravo' && password == '034013967'
    end
  end
end
