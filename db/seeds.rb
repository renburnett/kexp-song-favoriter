Song.delete_all
Artist.delete_all
Album.delete_all
User.delete_all


god_song = Song.create(title: "God Only Knows")
wou_song = Song.create(title: "Wouldnt it be Nice")

bboys = Artist.create(name: "The Beach Boys")
bboys.songs << god_song
bboys.songs << wou_song

pet_alb = Album.create(title: "Pet Sounds", year: 1966, genre: "Progressive Pop", artist: bboys)
ron1 = User.create(user_name: "ronny j", user_pass: "123")
ron1.favorite_songs << god_song