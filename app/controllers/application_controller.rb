class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery 
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name, :image, :job_title, :national_id, :date_of_birth, :location, :gender) }
  end

  layout :layout_by_resource



  def layout_by_resource
    if user_signed_in?
      "application"
    else
      "sign_up"
    end
  end


end




