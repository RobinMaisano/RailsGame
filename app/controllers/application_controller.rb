class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    unless current_user
      redirect_to new_user_session_path, alert: 'Unauthorized access'
    else
      redirect_to tournaments_path, alert: 'Unauthorized access'
    end
  end

end
