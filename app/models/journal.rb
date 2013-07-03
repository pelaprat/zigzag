class Journal < Item
  validates_presence_of :title
  validates_presence_of :isbn,  :uniqueness => true

  has_many  :articles

end
