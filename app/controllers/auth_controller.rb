class AuthController < ApplicationController
    #responsible for 
    # - authentication, 
    # - login action and 
    # - verification action

    def login
        
    end

    def verify
        #initialize an auth_token
        if @user = User.find_by(email: params[:email])
            session[:user_id] = @user.id
            redirect_to new_song_path
        else
            session[:user_id] = nil
            flash[:message] = "User not found!"
            redirect_to login_path
        end
    end

    def logout
        session.clear
        redirect_to login_path
    end

end