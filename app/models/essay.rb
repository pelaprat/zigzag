class Essay < Item
  validates_presence_of  :book
  belongs_to :book


end
