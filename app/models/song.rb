class Song < ApplicationRecord
    has_many :favorite_songs
    has_many :users, through: :favorite_songs

    belongs_to :artist
end
