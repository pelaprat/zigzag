class MarkTermsController < ApplicationController

  def create

    @term           = nil
    @mark_term      = nil
    @mark_term_new  = false

    # Get the item for this metting's mark
    @mark = Mark.find( params[:mark][:id] )
    @item = @mark.item

    ## Creating a relation to a Term?
    if params[:term][:name]
      @term = Term.find_or_create_by_name( params[:term][:name].capitalize )

    else
      params[:term].keys.each do |key| 
        if key =~ /term_\d+$/ 
          @term = Term.find( params[:term][key] )
         end
      end
    end

    ## Make the MarkTerm
    @mark_term  = MarkTerm.find_or_initialize_by_mark_id_and_term_id_and_user_id( @mark.id, @term.id, @current_user.id )

    if @mark_term.new_record?
      @mark_term_new = true
      @mark_term.save!
    end

    ## Add a User Term and Author Term
    @user_term    = UserTerm.find_or_create_by_user_id_and_term_id_and_author_id( @current_user.id, @term.id, @item.authors_ids_as_array )
    @author_term  = AuthorTerm.find_or_create_by_author_id_and_term_id( @item.authors_ids_as_array, @term.id )

    ## Handle the response
    respond_to do |format|

      format.js { 
        render  :partial  => 'javascript/meta/create_clickable',
                :locals   => {  :meta_relation_new_flag => @mark_term_new,
                                :meta_obj               => @term,
                                :relation_obj           => @mark_term, 
                                :main_obj_name          => 'mark',
                                :meta_obj_name_singular => 'term', :meta_obj_name_plural   => 'terms' }}

      format.html {
        redirect_to url_for(  :controller => :items,
                              :action     => :show,
                              :type       => @item.type, 
                              :id         => @item.id,
                              :anchor     => @mark.id  )
      }

    end
  end

  def destroy
    @mark_term  = MarkTerm.find( params[:id] )
    @mark       = @mark_term.mark
    @item       = @mark.item

    @mark_term.destroy

    respond_to do |format|

      format.js { 
        render  :partial  => 'javascript/meta/destroy_clickable',
                :locals   => {  :obj_meta_name => 'mark_term' }}

      format.html { redirect_to item_path( @item, :type => @item.type ), :success => 'Deleted!' }

    end
  end
end
