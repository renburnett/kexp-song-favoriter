class User < ApplicationRecord
    has_many :favorite_songs
    has_many :songs, through: :favorite_songs
end
