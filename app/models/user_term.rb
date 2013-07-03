class UserTerm < ActiveRecord::Base

  belongs_to  :user
  belongs_to  :term
  belongs_to  :author

#  if is_a_single_item_search?
#    
#    @user_terms   = UserTerm.joins([:term]).
#                             where({ :user_id => @current_user.id, :author_id => @item.authors_ids_as_array }).
#                             order( "terms.name asc").
#                             collect{ |ut| [ut.term.name, ut.term_id ] }
#  else
#    
#    prev_author = -1
#    
#    @user_terms   = UserTerm.joins([:term, :author]).
#                             where({ :user_id => @current_user.id }).
#                             order( "authors.last asc").
#                             collect{ |user_term| 
#                               if user_term.author_id != prev_author 
#                                 prev_author = user_term.author_id
#                                 [ user_term.author.fullname(:last), -1 ]
#                               else
#                                 [ '- '.concat(user_term.term.name), user_term.term_id ]
#                               end
#                             }
#  end

end
