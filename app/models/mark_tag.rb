class MarkTag < ActiveRecord::Base
  belongs_to  :mark
  belongs_to  :tag
  belongs_to  :user

  after_destroy   :update_mark_index
  after_save      :update_mark_index

  private

  def update_mark_index
    mark.index!
  end
end
