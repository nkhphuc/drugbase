class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
 
    before_action :configure_permitted_parameters, if: :devise_controller?
 
    protected
 
    def configure_permitted_parameters
      added_attrs = [:username, :name, :email, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

    private

    def require_signin
        unless user_signed_in?
            session[:intended_url] = request.url
            redirect_to signin_path, alert: "Please sign in first!"
        end
    end

    def current_workplace
        @current_workplace ||= Workplace.find(current_user[:workplace_id]) if user_signed_in?
    end

    def current_workplace?(workplace)
        current_workplace == workplace
    end
          
end
