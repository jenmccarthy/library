require './lib/authors.rb'
require './lib/books.rb'

class Copy
  
  attr_reader(:copies, :book_id, :id)
  
  def initialize(attributes)
    @copies = attributes['copies'].to_i
    @book_id = attributes['book_id'].to_i
    @id = attributes['id'].to_i
  end
  
  def Copy.all
    copies = []
    results = DB.exec("SELECT * FROM copies;")
    results.each do |result|
      current_copy = Copy.new(result)
      copies << current_copy
    end  
    copies
  end
  
  def save
    results = DB.exec("INSERT INTO copies (copies, book_id) VALUES (#{@copies}, #{@book_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end
  
  def ==(another_copy)
    @copies == another_copy.copies && @book_id == another_copy.book_id
  end
  
end