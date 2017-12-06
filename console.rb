require('pry-byebug')
require_relative('models/artist.rb')
require_relative('models/album.rb')
require_relative('db/sql_runner.rb')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  'name' => "Bono"
  })

artist2 = Artist.new({
  'name' => "Pink"
  })

artist1.save()
artist2.save()

artist1.name = "Freddie Mercury"
artist1.save()

#Artist.delete_one(artist2.id)

album1 = Album.new({
  'title' => 'Joshua Tree',
  'genre' => 'Rock',
  'artist_id' => artist1.id
  })

album1.save()

album1.genre = "Pop"
album1.save()

album2 = Album.new({
  'title' => 'The song of innocence',
  'genre' => 'Rock',
  'artist_id' => artist1.id
  })
album2.save()

puts "Artist.find_all()"
artists_list = Artist.find_all()
p artists_list

# albums_list = Album.find_all()
# p albums_list

puts "artist1.find_all_albums()"
artist1_albums_list = artist1.find_all_albums()
p artist1_albums_list

puts "album1.artist()"
p album1.artist()

puts "Album.find_album_by_title('Tr')"
p Album.find_album_by_title("of")

puts "Artist.delete_by_artist_id(artist1.id)"
Artist.delete_one(artist1.id)

p Artist.find_artist(artist1.id)
