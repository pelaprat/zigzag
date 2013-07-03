class User < ActiveRecord::Base

  has_secure_password

  attr_accessible :first, :last, :email, :password, :password_confirmation, :is_admin

  validates_presence_of   :first
  validates_presence_of   :last
  validates_presence_of   :email
  validates_uniqueness_of :email
  validates_presence_of   :password, :on => :create

  has_many  :marks

  has_many  :user_items
  has_many  :books,     :through => :user_items
  has_many  :chapters,  :through => :user_items
  has_many  :journals,  :through => :user_items
  has_many  :articles,  :through => :user_items

  has_many  :user_authors
  has_many  :authors,  :through => :user_authors

  has_many  :user_terms
  has_many  :terms, :through => :user_terms

  has_many  :user_tags
  has_many  :tags,  :through => :user_tags

  searchable :auto_index => true, :auto_remove => true do
      text :first
      text :last, :boost => 2.0
      text :email
  end

  public

  def fullname
    first + ' ' + last
  end

end
