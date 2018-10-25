class ApplicationController < ActionController::Base
  helper_method :current_user, :round

  include ActionView::Helpers::NumberHelper

  def current_user
    return nil if session[:user_id].nil?

    User.find(session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to login_path, notice: 'you should be signed in' if current_user.nil?
  end

  def round(float)
    i = 0;
    n = (number_with_precision(float, precision: 2).to_f - number_with_precision(float, precision: 1).to_f) * 100
    i = 0.1 if n >= 5.0
    number_with_precision(float, precision: 1).to_f + i
  end
end
