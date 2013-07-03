class Term < ActiveRecord::Base
  validates_presence_of   :name

  has_many    :author_terms
  has_many    :authors, :through => :author_terms

  has_many    :mark_terms
  has_many    :marks, :through => :mark_terms

  has_many    :search_terms
  has_many    :searches, :through => :search_terms

  has_many    :user_terms
  has_many    :users, :through => :user_terms

  def clean_name 
    name.capitalize
  end
end
