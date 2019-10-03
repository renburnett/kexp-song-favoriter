class UsersController < ApplicationController
    before_action :security, only: [:show, :favorites, :save_favorite, :destroy_favorite]
    
    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new()
    end

    def create
        @user = User.new(user_params)
        if @user.save()
            session[:user_id] = @user.id
            redirect_to songs_path
        else
            flash[:message] = "An error occurred upon login! \n Please try again."
            render :new
        end
    end

    def favorites #show users favorite songs
        @user = current_user
    end

    def save_favorite
        @user = current_user()
        #if song already exists in user favorites flash message and route back to songs index
        if !@user.songs.find_by(id: params[:id])
            @favorite_song = Song.find_by(id: params[:id])
            @user.songs << @favorite_song
            render :favorites
        else
            flash[:message] = "You've already favorited that song silly! \nPick a different song!"
            redirect_to songs_path
        end
    end

    def destroy_favorite
        @user = current_user()
        #Delete the join table link, not the song!
        @song_to_destroy = @user.favorite_songs.find_by(song_id: params[:id])
        if @song_to_destroy.delete()
            render :favorites
        else
            flash[:message] = "Error when deleting item with id: #{params[:id]}"
            render :favorites 
        end
    end
        
    private

    def user_params
        params.require(:user).permit(:email, :user_name, :user_pass)
    end
end
