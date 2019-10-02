require 'rest-client'
require 'json'

class SongsController < ApplicationController
    def index
        @songs = Song.all
    end
    
    def show
        @song = Song.find(params[:id])
        @artist = @song.artist
        @album = @song.artist.album
    end

    def new
        #nothing needed, just the api call button
    end

    #create makes api calls for 20 recent songs from kexp, and their corresponding genres -> updates db
    def create
        songs = get_kexp_songs()
        idx = 0
        
        #TODO: #songs['results'].length do    #should loop over the 20 song elements
        5.times do
            if songs['results'][idx]['playtype']['name'] != "Air break" && songs['results'][idx]['playtype']['name'] != "Air Break"
                song_title = songs['results'][idx]['track']['name']
                song_artist = songs['results'][idx]['artist']['name']
                song_album = songs['results'][idx]['release']['name']
                song_is_local = songs['results'][idx]['artist']['islocal']
                song_release_year = songs['results'][idx]['releaseevent']['year'].to_i
                
                #if song|artist|album don't exist -> create 
                if Album.find_by(title: song_album) == nil
                    song_artist = song_artist.split('feat.')[0]
                    mod_artist = song_artist.strip().split(' ').join('+')
                    parsed_response = get_song_genre(mod_artist)
    
                    #if bad status code -> query by song instead
                    if parsed_response["status_code"] > 299 || parsed_response["status_code"] < 200 || parsed_response["genre"] == ""
                        mod_song = song_title.strip().split(' ').join('+')
                        parsed_response = get_song_genre(mod_song)
                    end
    
                    @album = Album.new(title: song_album, year: song_release_year, genre: parsed_response["genre"])
                    @album.save()
                else 
                    @album = Album.find_by(title: song_album)
                end
                if Artist.find_by(name: song_artist) == nil
                    @artist = Artist.new(name: song_artist, is_local?: song_is_local, album: @album)
                    @artist.save()
                else 
                    @artist = Artist.find_by(name: song_artist)
                    @artist.update(album: @album)
                end
                if Song.find_by(title: song_title) == nil
                    @song = Song.new(title: song_title, artist: @artist)
                    @song.save()
                else 
                    @song = Song.find_by(title: song_title)
                    @song.update(artist: @artist)
                end
                
                idx += 1
            end
        end
        redirect_to songs_path
    end

    private 

    def album_params
        params.require(:album).permit(:title, :year, :genre, :artist)
    end

    def get_kexp_songs
        url = "https://legacy-api.kexp.org/play/"
        response = RestClient.get(url)
        body = JSON.parse(response.body)
    end

    def get_song_genre(song_or_artist)
        url = "http://api.musixmatch.com/ws/1.1/track.search?q_track=#{song_or_artist}&page_size=6&s_track_rating=desc&apikey=d724f77b3d9ea7b37948f7baecea0291"
        response = RestClient.get(url)
        body = JSON.parse(response.body)
        idx = 0
        parsed_response = {}
        parsed_response["status_code"] =  body["message"]["header"]["status_code"]

        if !body["message"]["body"]["track_list"].empty? #first annoying empty check
            while body["message"]["body"]["track_list"][idx]["track"]["primary_genres"].empty?  #iterate until a non-empty genre is hit
                idx += 1
            end
        else 
            parsed_response["genre"] = ""
            return parsed_response
        end

        begin
            parsed_response["genre"] = body["message"]["body"]["track_list"][idx]["track"]["primary_genres"]["music_genre_list"][0]["music_genre"]["music_genre_name"]
        rescue
            parsed_response["genre"] = ""
        end

        return parsed_response
    end

end
