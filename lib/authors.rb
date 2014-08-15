require './lib/books.rb'

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
  
  def books
    books = []
    results = DB.exec("SELECT books.* FROM
                      authors JOIN books_authors ON (authors.id = books_authors.author_id)
                      JOIN books ON (books_authors.book_id = books.id)
                      WHERE authors.id = '#{self.id}';")
    results.each do |result|
      books << Book.new(result)
    end
    books
  end
 
end