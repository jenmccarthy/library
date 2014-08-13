class Author
  
  attr_accessor :name, :id

  def initialize(attributes) 
    @name = attributes['name']
    @id = attributes['id'].to_i
  end
  
  def Author.all 
    authors = []
    results = DB.exec("SELECT * FROM authors;")
    results.each do |result|
      current_author = Author.new(result)
      authors << current_author
    end  
    authors
  end
  
  def save
    results = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end
  
  def ==(another_author)
    @name == another_author.name && @id == another_author.id
  end
  
  def delete
    DB.exec("DELETE FROM authors WHERE id = #{self.id};")
  end
 
end