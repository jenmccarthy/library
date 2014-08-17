require 'pg'
require './lib/authors.rb'
require './lib/books.rb'


DB = PG.connect({:dbname => 'library_development'})

def welcome
  puts "Welcome to the Epic County Library Catalog Search\n\n"
  menu
end

def menu
  loop do
    puts "Press [a] to add a new book and author to the system"
    puts "Press [l] to list the library's current books"
    puts "Press [v] to view the authors of the current books at the library"
    puts "Press [q] to see the library's current authors"
    puts "Press [c] to add a copy of a book already in the system"
    puts "Press [u] to add a book to an already existing author in the system"
    puts "Press [s] to search the catalog by book title or author"
    puts "Press [x] to exit"
    main_choice = gets.chomp
      if main_choice == 'a'
        add_book
      elsif main_choice == 'l'
        list_books
      elsif main_choice == 'v'
        view_author
      elsif main_choice == 'q'
        list_authors
      elsif main_choice == 'c'
        add_copy
      elsif main_choice == 'u'
        add_book_to_author
      elsif main_choice == 's'
        catalog_search
      elsif main_choice == 'x'
        puts "Good-bye!"
        exit
      else
        puts "Sorry, that wasn't a valid option."
      end
  end
end

def add_book
  puts "Enter the book title:"
  input_title = gets.chomp
  puts "Enter the number of copies of this book:"
  copies = gets.chomp.to_i
  puts "Enter the author of this book:"
  author = gets.chomp
  new_book = Book.new({'title' => input_title, 'copies' => copies})
  new_book.save
  new_author = Author.new('name' => author)
  new_author.save
  new_book.add_author(new_author)
  puts "This book has been added to the Epic County Library System!\n\n"
  menu
end

def list_books
  puts "The current books in the Epic Country Library:\n\n"
  if Book.all.empty?
    puts "Your current library catalog is empty!\n\n"
    menu
  else
    Book.all.each_with_index do |book, index|
      puts (index + 1).to_s + " " + book.title
    end
  end 
end

def list_authors
  puts "The current authors in the Epic County Library:\n\n"
  if Author.all.empty?
    puts "Your current library catalog has no authors!\n\n"
    menu
  else
    Author.all.each_with_index do |author, index|
      puts (index + 1).to_s + " " + author.name
    end
  end
end
  
def view_author
  puts "Please choose a book to view who authored it:\n\n"
  list_books
  choice = gets.chomp.to_i
  book = Book.all[choice - 1]
  authors = book.authors
  authors.each do |author|
    puts author.name
    puts "\n\n"
  end
  menu
end

def add_copy
  list_books
  puts "Please choose the book to which you would like to add a copy:"
  book_choice = gets.chomp.to_i
  book = Book.all[book_choice -1]
  puts "How many copies would you like to add?"
  copies_amount = gets.chomp.to_i
  book.update_copy(copies_amount)
  puts "This book has been updated to have #{book.copies} copies!\n\n"
end

def add_book_to_author
  list_authors
  puts "To which author would you like to add another book title?"
  choice = gets.chomp.to_i
  puts "Please enter the title of the book:"
  title = gets.chomp
  puts "Please enter the number of copies of this book:"
  copies = gets.chomp.to_i
  author = Author.all[choice - 1]
  new_book = Book.new({'title' => title, 'copies' => copies})
  new_book.save
  new_book.add_author(author)
  puts "This book title has been saved to the chosen author!"
end


def catalog_search
  puts "Press [t] to search by title"
  puts "Press [a] to search by author"
  choice = gets.chomp
  if choice == 't'
    title_search
  elsif choice == 'a'
    author_search
  else 
    puts "Sorry that wasn't a valid option"
  end
end

def title_search
  @book_titles = []
  puts "Please enter a book title to see if the Epic County Library owns it:"
  input_title = gets.chomp
  Book.all.each do |book|
    @book_titles << book.title
  end
  if @book_titles.include?(input_title)
    puts "Yes we carry #{input_title}."
  else
      puts "That is not something we have at this time!\n\n"
  end
end

def author_search
  @authors = []
  puts "Please enter the author you would like to search for:"
  input_author = gets.chomp
  Author.all.each do |author|
    @name = author.name
    @authors << author.name
  end
  if @authors.include?(input_author)
    puts "Yes we carry that author."
  else
    puts "We do not carry that author at this time"
  end
end
welcome


