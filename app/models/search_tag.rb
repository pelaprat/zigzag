class SearchTag < ActiveRecord::Base
  belongs_to :search
  belongs_to :tag
end
