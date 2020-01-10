# Kexp Song Favoriting App

APIs used:
* https://developer.musixmatch.com/documentation
* https://legacy-api.kexp.org/

This is app queries the kexp api for the 20 most recent songs played and saves them to a postgresql db.
It then queries the musix_match api for the genre of the song (not a great api for that. . . might remove.)

Within the app you can:
  - login/logout
  - view all saved songs
  - favorite songs to your user-library
  - view details about each individual song
  
NOTE: You might have trouble logging from time to time in as I am hosting all my projects on the free tier of Heroku

Future Goals:
  - fix or remove the genre api call
  	- give album art to song 
		- query image api for artist images
	  - give join table to allow many-to-many relationship between artist and albums
		  - split artist string on `.feat` and allow multiple artists per album
    - hook up to apple_library api to purchase songs?
