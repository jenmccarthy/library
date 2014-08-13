class Book 
  
  attr_accessor :title, :id

  def initialize(attributes) 
    @title = attributes['title']
    @id = attributes['id'].to_i
  end
  
  def Book.all 
    books = []
    results = DB.exec("SELECT * FROM books;")
    results.each do |result|
      current_book = Book.new(result)
      books << current_book
    end  
    books
  end
  
  def save
    results = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = results.first['id'].to_i
  end
  
  def ==(another_book)
    @title == another_book.title && @id == another_book.id
  end
  
  def delete
    DB.exec("DELETE FROM books WHERE id = #{self.id};")
  end
  
  def add_author(input_author)
    DB.exec("INSERT INTO books_authors (book_id, author_id) VALUES (#{self.id}, #{input_author.id});")
  end
  
  def authors
    authors = []
    results = DB.exec("SELECT authors.* FROM books
                        JOIN books_authors ON (books.id = books_authors.book_id)
                        JOIN authors ON (books_authors.author_id = authors.id)
                        WHERE books.id = #{self.id}")
    results.each do |result|
      authors << Author.new(result)
    end
    authors
  end
end