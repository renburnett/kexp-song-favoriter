class User < ApplicationRecord
    has_many :favorite_songs
    has_many :songs, through: :favorite_songs

    validates :user_name, :user_pass, :email, presence: true
    validates :email, uniqueness: true
end
