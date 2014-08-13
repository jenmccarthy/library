require 'rspec'
require 'books'
require 'authors'
require 'pg'

DB = PG.connect({:dbname => 'library_test'})


  RSpec.configure do |config|
    config.after(:each) do
      DB.exec("DELETE FROM authors *;")
    end
  end

describe Author do
  
  it 'will initialize an author instance with a name' do
    test_author = Author.new({'name' => 'Stephen King'})
    expect(test_author).to be_an_instance_of Author
  end
  
  it 'will read out the name of an author' do
    test_author = Author.new({'name' => 'Stephen King'})
    expect(test_author.name).to eq 'Stephen King'
  end
  
  it 'will save all instances of the Author class' do
    test_author = Author.new({'name' => 'Stephen King'})
    test_author.save
    expect(Author.all).to eq [test_author]
  end
  
  it 'will delete an author' do
    test_author = Author.new({'name' => 'Stephen King'})
    another_test_author = Author.new({'name' => 'Dan Brown'})
    test_author.save
    another_test_author.save
    another_test_author.delete
    expect(Author.all).to eq [test_author]
  end
  
  it 'returns all books by an author' do
    test_book = Book.new({'title' => 'Carrie'})
    test_book.save
    another_test_book = Book.new({'title' => 'It'})
    another_test_book.save
    test_author = Author.new({'name' => 'Margaret Mitchell'})
    test_author.save
    test_book.add_author(test_author)
    another_test_book.add_author(test_author)
    expect(test_author.books).to eq [test_book, another_test_book]
  end

end