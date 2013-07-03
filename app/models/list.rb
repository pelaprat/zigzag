class List < ActiveRecord::Base
  # Makes sure we have name
  validates_presence_of  :name

  # Belongs to a user
  belongs_to  :user

  # Has many items of different kinds
  has_many  :list_items
  has_many  :books,     :through => :list_items
  has_many  :chapters,  :through => :list_items
  has_many  :journals,  :through => :list_items
  has_many  :articles,  :through => :list_items

  searchable :auto_index => true, :auto_remove => true do
      text :name
  end

end
