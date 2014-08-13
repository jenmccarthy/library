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
 
end