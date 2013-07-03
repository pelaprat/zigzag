class ItemAuthor < ActiveRecord::Base
  belongs_to  :item
  belongs_to  :author

  after_destroy   :update_item_author_index
  after_save      :update_item_author_index

  private

  def update_item_author_index
  end
end
