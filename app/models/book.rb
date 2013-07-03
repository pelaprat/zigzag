class Book < Item
  validates :isbn, :presence => true, :uniqueness => true

  has_many  :book_chapters
  has_many  :chapters,  :through => :book_chapters

  searchable :auto_index => true, :auto_remove => true do
    text    :title
    text    :all_chapter_titles_as_array

    string  :type
    string  :title
  end

  private

  def all_chapter_titles_as_array
    chapters.map { |chapter| chapter.title }
  end

end
