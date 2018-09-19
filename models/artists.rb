require("pg")
require_relative("../db/sql_runner")

class Artist
  attr_reader :id
  attr_accessor :artist_name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @artist_name = options["artist_name"]
  end

  def save()
    sql = "INSERT INTO artists (artist_name) VALUES ($1)
    RETURNING id"
    values = [@artist_name]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

# should this return an array of Artist names?
# Or just list out strings of artist names?
# currently does the former
  def self.list_all()
    sql = "SELECT * FROM artists"
    result = SqlRunner.run(sql)
    artist_array = result.map { |artist_hash| Artist.new(artist_hash)}
    return artist_array.map {|artist_object| artist_object.artist_name}
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    result = SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE artists SET artist_name = $1 WHERE id = $2"
    values = [@artist_name, @id]
    result = SqlRunner.run(sql, values)
  end

# List all the albums he has by an artist
# now it returns an array with all the album names
def albums()
  sql = "SELECT album_name FROM albums WHERE artist_id = $1"
  values = [@id]
  result = SqlRunner.run(sql, values)
  return album_name_array = result.map {|album_hash| album_hash["album_name"]}
end

def self.find(id)
  sql = "SELECT * FROM artists WHERE id = $1"
  values = [id]
  result = SqlRunner.run(sql, values)
  artist_hash = result.first
  artist = Artist.new(artist_hash)
  return artist
end


end
