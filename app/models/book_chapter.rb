class BookChapter < ActiveRecord::Base
  belongs_to  :book
  belongs_to  :chapter

end
