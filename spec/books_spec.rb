require 'spec_helper'

describe Book do
  
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
  
  it 'will delete a book' do
    test_book = Book.new({'title' => 'Gone With the Wind'})
    another_test_book = Book.new({'title' => 'Animal Farm'})
    test_book.save
    another_test_book.save
    test_book.delete
    expect(Book.all).to eq [another_test_book]
  end
  
  it 'will add an author to a book instance' do
    test_book = Book.new({'title' => 'Gone With the Wind'})
    test_book.save
    test_author = Author.new({'name' => 'Margaret Mitchell'})
    test_author.save
    test_book.add_author(test_author)
    expect(test_book.authors).to eq [test_author]
  end

end