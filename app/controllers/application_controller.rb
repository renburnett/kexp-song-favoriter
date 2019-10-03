class ApplicationController < ActionController::Base
    helper_method :security, :logged_in?, :current_user

    def security
        if !session[:user_id]
            flash[:login_please] = "Please login first!"
            redirect_to login_path
        end
    end

    def logged_in?
        session[:user_id]
    end

    def current_user
        if logged_in?
            User.find(session[:user_id])
        end
    end
end
