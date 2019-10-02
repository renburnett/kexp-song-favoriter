Song.delete_all
Artist.delete_all
Album.delete_all
User.delete_all

# idx = 0

10.times do
    # song = Song.create(title: Faker::Music::Opera.verdi)
    # song_1 = Song.create(title: Faker::Music::Phish.song)
    # band = Artist.create(name: Faker::Music.band)
    # band.songs << song
    # band.songs << song_1
    # Album.create(title: Faker::Music.album, year: 1966, genre: Faker::Music.genre, artist: band)

    # if idx % 2 == 0
    user = User.create(user_name: Faker::Name.first_name, user_pass: "123")
        # user.songs << song_1
    # end
end