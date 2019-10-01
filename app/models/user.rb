class User < ApplicationRecord
    has_many :songs
    has_many :songs, through: :favorite_songs
end
