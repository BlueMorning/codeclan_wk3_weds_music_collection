require ('pry-byebug')
require_relative ('../db/sql_runner')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  # class methods

  # CARE: deleting any item in the artist array will only be successful if the associated album has been deleted first.

  #Delete all the artists
  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  #Delete one artist by id
  def self.delete_one(id)
    sql = "DELETE FROM artists WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  #Get all the artist
  def self.find_all()
    sql = "SELECT id, name FROM artists"
    return SqlRunner.run(sql).map{|artist| Artist.new(artist)}
  end

  #Get an artist from his/her id
  def self.find_artist(artist_id)
    sql = "SELECT id, name FROM artists WHERE id = $1"
    return Artist.new(SqlRunner.run(sql, [artist_id]).first())
  end


  # instance methods
  #Save an artist, the method manages wether we need to insert or update
  def save()
    if @id
      update()
    else
      insert()
    end
  end

  #Find all the artist's album
  def find_all_albums()
    return Album.find_albums_by_artist(@id)
  end



  private
  def insert()
    sql     = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
    values  = [@name]
    @id     = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql     = "UPDATE artists SET name = $1 WHERE id = $2"
    values  = [@name, @id]
    SqlRunner.run(sql, values)
  end

  # don't add any public / protected methods here

end




# artist.rb
