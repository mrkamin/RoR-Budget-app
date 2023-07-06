class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    def after_sign_in_path_for(_user)
      categories_path
    end
  
    def after_sign_out_path_for(_resource_or_scope)
      splash_path
    end
  
    protected
  
    def configure_permitted_parameters
      # attributes = [:name, :photo, :bio, :role] alternative to below
      attributes = %i[name]
      devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
      devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    end
  
    def authenticate_user!
      if user_signed_in?
        users_path
      else
        redirect_to new_user_session_path unless devise_controller?
      end
    end
  end