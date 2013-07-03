class Tag < ActiveRecord::Base
  validates_presence_of   :name

  has_many    :mark_tags
  has_many    :marks, :through => :mark_tags

  has_many    :search_tags
  has_many    :searches, :through => :search_tags

  has_many    :user_tags
  has_many    :users, :through => :user_tags

  def clean_name 
    name.capitalize
  end
end
