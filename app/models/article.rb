class Article < Item
  validates_presence_of :title
  validates_presence_of :journal_id

  belongs_to :journal

end
