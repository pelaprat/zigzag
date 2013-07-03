class SearchTermsController < ApplicationController

  def create

    term_id = -1

    params[:term].keys.each do |key|
      if key =~ /term_\d+$/ && params[:term][key].to_i > 0
        term_id = params[:term][key].to_i
      end
    end

    if term_id > 0

      @search_term     = nil
      @search_term_new = false
      
      # Get the search
      @search = Search.find( params[:search][:id] )
      @term   = Term.find( term_id )

      ## Make the SearchTerm
      @search_term  = SearchTerm.find_or_initialize_by_search_id_and_term_id( @search.id, @term.id )
      
      if @search_term.new_record?
        @search_term_new = true
        @search_term.save!
      end

      ## Add a Search Term
      @search_term    = SearchTerm.find_or_create_by_search_id_and_term_id( @search.id, @term.id )
    end

    ## Handle the response
    respond_to do |format|
      format.js { 
        if term_id > 0
          render  :partial  => 'javascript/meta/create_clickable',
                  :locals   => {  :meta_relation_new_flag => @search_term_new,
                                  :meta_obj               => @term,
                                  :relation_obj           => @search_term, 
                                  :main_obj_name          => 'search',
                                  :meta_obj_name_singular => 'term', :meta_obj_name_plural   => 'terms' }
        else
          render :layout => false
          return
        end
      }

      format.html {
        redirect_to url_for(  :controller => :searches,
                              :action     => :show,
                              :id         => @search.id  )
      }

    end
  end

  def destroy
    @search_term = SearchTerm.find( params[:id] )
    @search     = @search_term.search

    @search_term.destroy

    respond_to do |format|
      format.js { 
        render  :partial  => 'javascript/meta/destroy_clickable',
                :locals   => {  :obj_meta_name => 'search_term' }}

      format.html { redirect_to search_path( @search ), :success => 'Deleted!' }
    end
  end
end
