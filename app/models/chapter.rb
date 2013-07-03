class Chapter < Item
  belongs_to :book

  searchable :auto_index => true, :auto_remove => true  do
      text :title
  end
end
