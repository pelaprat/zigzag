class Item < ActiveRecord::Base
  validates_presence_of         :title

  has_many  :item_authors
  has_many  :authors,  :through => :item_authors

  has_many  :marks

  has_many  :user_items
  has_many  :users, :through => :user_items


  searchable :auto_index => true, :auto_remove => true do
    string  :title
    string  :author_name
    text    :meta_data
  end

  public

  def author_name
    authors.empty? ? '' : authors.first.last
  end

  def authors_ids_as_array
    authors.empty? ? [] : authors.map { |author| author.id }
  end

  def authors_names_as_array
    authors.empty? ? [] : authors.map { |author| author.fullname(:first) }
  end

  def chapters_titles_as_array
    chapters.empty? ? [] : chapters.map { |chapter| chapter.title.split(/\s+/) }
  end

  def meta_data
    strings = title.split(/\s+/)
    strings | authors_names_as_array

    if type.to_s.eql? 'Book'
      strings | chapters_titles_as_array
    end

    strings.uniq
  end
end
