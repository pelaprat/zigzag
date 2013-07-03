class UserItem < ActiveRecord::Base
  belongs_to  :user

  belongs_to  :item
  belongs_to  :book,      :foreign_key => :item_id, :class_name => "Book"
  belongs_to  :chapter,   :foreign_key => :item_id, :class_name => "Chapter"
  belongs_to  :journal,   :foreign_key => :item_id, :class_name => "Journal"
  belongs_to  :article,   :foreign_key => :item_id, :class_name => "Article"

  searchable :auto_index => true, :auto_remove => true do

    integer :user_id, :references => User
    integer :author_id, :multiple => true do
      item.authors_ids_as_array
    end

    ##### Texts #####
    text  :title do
      item.title
    end

    text  :chapter_titles do
      if item.type.eql? 'Book'
        item.chapters.map { |chapter| chapter.title }
      end
    end

    text  :year do
      item.year
    end

    text :authors_names do
      item.authors_names_as_array.join(' ')
    end

    ##### Strings #####
    string  :author_name do
      item.authors.empty? ? '' : item.authors.first.last
    end

    string  :title do
      item.title
    end

    string  :type do
      item.type
    end

    string  :year do
      item.year
    end
  end

end
