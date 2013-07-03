class AuthorTerm < ActiveRecord::Base
  belongs_to :author
  belongs_to :term

  def self.number_of_terms_for_author( author_id = NULL )
    if author_id.is_a? Integer && author.id > 0
      AuthorTerm.where({:author_id => author_id}).count
    else
      0
    end
  end

end
