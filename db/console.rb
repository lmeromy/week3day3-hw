require("pry")
require_relative("../models/albums")
require_relative("../models/artists")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({"artist_name" => "Amy Winehouse"})
artist1.save()

artist2 = Artist.new({
  "artist_name" => "Oasis"
  })

artist2.save()

album1 = Album.new({
  "album_name" => "Back to Black",
  "genre" => "pop",
  "artist_id" => artist1.id
  })

album1.save()

album2 = Album.new({
  "album_name" => "(What's the story) Morning Glory?",
  "genre" => "rock",
  "artist_id" => artist2.id
  })

album2.save()

album3 = Album.new({
  "album_name" => "Be Here Now",
  "genre" => "rock",
  "artist_id" => artist2.id
  })

album3.save()

Artist.list_all()
Album.list_all()

album1.genre = "pop/jazz/r&b"
album1.update()

artist2.artist_name = "OASIS"
artist2.update()

album1.artist()
artist2.albums()

find1 = Artist.find(artist1.id)
find2 = Album.find(album1.id)

binding.pry
nil
