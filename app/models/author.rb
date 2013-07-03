class Author < ActiveRecord::Base
  validates_presence_of :first
  validates_presence_of :last

  has_many  :item_authors
  has_many  :items, :through => :item_authors

  has_many  :articles
  has_many  :books
  has_many  :chapters
  has_many  :essays
  has_many  :journals

  has_many  :author_terms
  has_many  :terms, :through => :author_terms

  has_many  :search_authors
  has_many  :searches, :through => :search_authors

  has_many  :user_authors
  has_many  :users, :through => :user_authors

  searchable :auto_index => true, :auto_remove => true do
      text :first
      text :last, :boost => 2.0
      text :fullname, :boost => 1.0
  end

  def fullname( format = :last )
    if format == :last
      self.last + ', ' + self.first
    elsif format == :first
      self.first + ' ' + self.last
    end
  end
end
