class Mark < ActiveRecord::Base
  validates_presence_of :type
  validates_presence_of :item
  validates_presence_of :user
  validates_presence_of :page
  validates_presence_of :comment

  belongs_to :item
  belongs_to :user

  searchable :auto_index => true, :auto_remove => true do

    integer   :id
    integer   :item_id, :references => Item
    integer   :user_id, :references => User
    integer   :page
    integer   :section

    integer   :tag_ids, :multiple => true do
      tags.map(&:id)
    end

    integer   :term_ids, :multiple => true do
      terms.map(&:id)
    end

    string    :type
    string    :area

    text      :quote, :boost => 3
    text      :comment
    text      :all_tags_as_array
    text      :all_terms_as_array

    time      :created_at
    time      :updated_at
  end

  has_many :mark_tags
  has_many :tags,   :through => :mark_tags

  has_many :mark_terms
  has_many :terms,  :through => :mark_terms

  private

  def all_tags_as_array
    tags.map { |tag| tag.name }
  end

  def all_terms_as_array
    terms.map { |term| term.name }
  end

  public

  def quote_or_comment
    quote.empty? ? comment : quote
  end

  def quote_or_comment_with_keywords( k )
    if k.kind_of? String
      k = k.split(/s+/)
    end

    k.each do |x|
      if quote.match( /#{x}/i )
        return quote
      end
    end

    comment
  end


end
