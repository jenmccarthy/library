require 'rspec'
require 'books'
require 'pg'

DB = PG.connect({:dbname => 'library_test'})

describe Book do
  
  RSpec.configure do |config|
    config.after(:each) do
      DB.exec("DELETE FROM books *;")
    end
  end
  
  it 'will initialize a book instance with a title' do
    test_book = Book.new({'title' => 'Gone With the Wind'})
    expect(test_book).to be_an_instance_of Book
  end
  
  it 'will read out the title of a book' do
    test_book = Book.new({'title' => 'Gone With the Wind'})
    expect(test_book.title).to eq 'Gone With the Wind'
  end
  
  it 'will save all instances of Book class' do
    test_book = Book.new({'title' => 'Gone With the Wind'})
    test_book.save
    expect(Book.all).to eq [test_book]
  end

end