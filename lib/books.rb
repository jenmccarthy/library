class Book 
  
  attr_accessor :title, :id

  def initialize(attributes) 
    @title = attributes['title']
    @id = attributes['id']
  end
 
end