class UserAuthor < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :author

end
