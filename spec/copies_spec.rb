require 'spec_helper'

describe Copy do
  
  it 'will initialze a copy instance with a hash of attributes' do
    test_copy = Copy.new({'copies' => 4, 'book_id' => 1})
    expect(test_copy).to be_an_instance_of Copy
  end
    

  it 'will read out the copies and book_id' do
    test_copy = Copy.new({'copies' => 4, 'book_id' => 1})
    expect(test_copy.copies).to eq 4
    expect(test_copy.book_id).to eq 1
  end

  it 'lets you save copies to the database' do
    test_copy = Copy.new({'copies' => 4, 'book_id' => 1})
    test_copy.save
    expect(Copy.all).to eq [test_copy]
  end

  it 'is the same copy when the id and book_id are the same' do
    test_copy = Copy.new({'copies' => 4, 'book_id' => 1})
    another_test_copy = Copy.new({'copies' => 4, 'book_id' => 1})
    test_copy.save
    another_test_copy.save
    expect(test_copy).to eq another_test_copy
  end
end