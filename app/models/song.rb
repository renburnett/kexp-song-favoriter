class Song < ApplicationRecord
    belongs_to :artist
    
    has_many :users
    has_many :users, through: :favorite_songs

    
end
