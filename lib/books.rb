class Book 
  
  attr_accessor :title, :id

  def initialize(attributes) 
    @title = attributes['title']
    @id = attributes['id'].to_i
  end
  
  def self.all 
    books = []
    results = DB.exec("SELECT * FROM books;")
    results.each do |result|
      books << Book.new(result)
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
 
end