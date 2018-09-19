require("pg")
require_relative("../db/sql_runner")

class Album
  attr_accessor :album_name, :genre, :artist_id
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @album_name = options["album_name"]
    @genre = options["genre"]
    @artist_id = options["artist_id"].to_i
  end

  def save()
    sql = "INSERT INTO albums (album_name, genre, artist_id)
    VALUES ($1, $2, $3) RETURNING *"
    values = [@album_name, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  # like artists: should this return an array of Album names?
  # Or just list out strings of album names?
  # currently does the former
  def self.list_all()
    sql = "SELECT * FROM albums"
    results = SqlRunner.run(sql)
    album_array = results.map {|album| Album.new(album)}
    # list_of_albums = []
    # for album in results
    # list_of_albums << album[:album_name]
    # end
    # return list_of_albums
    # return album_array.album_name
    # return results[0].album_name
    return album_array.map {|album_object| album_object.album_name}
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    result = SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE albums SET (album_name, genre, artist_id) =
    ($1, $2, $3) WHERE id = $4"
    values = [@album_name, @genre, @artist_id, @id]
    result = SqlRunner.run(sql, values)
  end


  # Show the artist any album belongs to
  def artist()
    sql = "SELECT artist_name FROM artists WHERE id = $1"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    return result[0]["artist_name"]
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    album_hash = result.first
    album = Album.new(album_hash)
    return album
  end



end
