class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to root_path, alert: "No tienes autorizacion, fuera!!!"
    else
      redirect_to new_user_session_path, alert: "Por favor logueate, CTM"
    end
  end

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:name, :lastname, :username]
      devise_parameter_sanitizer.for(:account_update) << [:name, :lastname, :username]
    end
end
