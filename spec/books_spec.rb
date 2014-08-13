require 'rspec'
require 'books.rb'

describe Book do
  
  it 'will initialize a book instance with a title' do
    test_book = Book.new({'title' => 'Gone With the Wind'})
    expect(test_book).to be_an_instance_of Book
  end
  
  it 'will read out the title of a book' do
    test_book = Book.new({'title' => 'Gone With the Wind'})
    expect(test_book.title).to eq 'Gone With the Wind'
  end

end