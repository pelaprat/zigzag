class JournalArticle < ActiveRecord::Base
  belongs_to  :journal
  belongs_to  :article

end
