class ListItem < ActiveRecord::Base
  belongs_to  :list

  belongs_to  :item
  belongs_to  :book,      :foreign_key => :item_id, :class_name => "Book"
  belongs_to  :chapter,   :foreign_key => :item_id, :class_name => "Chapter"
  belongs_to  :journal,   :foreign_key => :item_id, :class_name => "Journal"
  belongs_to  :article,   :foreign_key => :item_id, :class_name => "Article"

end
