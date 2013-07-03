class Search < ActiveRecord::Base

  attr_accessor         :marks

  belongs_to            :user

  has_many              :search_authors
  has_many              :authors, :through   => :search_authors

  has_many              :search_tags
  has_many              :tags, :through   => :search_tags

  has_many              :search_terms
  has_many              :terms, :through  => :search_terms

  def set_meta_from_params_hash( meta, params_hash )
    unless params_hash.nil?
      identifiers = []

      params_hash.each do |key, value|
        if key.match("select-search-#{id}-#{meta}")
          identifiers.push( value )
        end
      end

      set_meta_from_array_of_identifiers( meta, identifiers )
    end
  end   

  def set_meta_from_array_of_identifiers( meta, identifiers )
    unless identifiers.nil?
      identifiers.uniq!

      if meta.eql? 'tag'
        @new_objects = Tag.where({ :id => identifiers })
        self.tags = @new_objects
      elsif meta.eql? 'meta'
        @new_objects = Term.where({ :id => identifiers })
        self.terms = @new_objects
      end
    end
  end


  def sanitize_keywords
    @keywords.strip!
  end

  def exists_keywords?
    (@keywords.is_a? String) && (not @keywords.blank?) ? true : false
  end


end
