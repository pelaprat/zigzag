class SearchAuthor < ActiveRecord::Base
  belongs_to :search
  belongs_to :author
end
