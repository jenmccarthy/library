##Library

###Description

This program will catalog a library's books with name and author.  It will allow a librarian to search and update the catalog.  
This does not include functionality for a patron search or checkout yet.  This will satisfy the database basics assessment.

###Implementation

Please run the command: ruby catalog_search.rb in the terminal.  This program requires a database named library_development
and three tables within that database.  The tables are books with a column for a serialized id, a column for book title of 
type varchar, and a column for copies amount of type integer.  The second table is for authors with a column for a 
serialized id, and a column for a an author name of type varchar.  The third table is a join table between books and authors
with a column for a serialized id, a column for book_id of type integer, and a column for author_id of type integer.

###Authored By:
Jennifer McCarthy
