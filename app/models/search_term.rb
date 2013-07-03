class SearchTerm < ActiveRecord::Base
  belongs_to :search
  belongs_to :term
end
