class SearchTagsController < ApplicationController

  def create

    @tag            = nil
    @search_tag     = nil
    @search_tag_new = false

    # Get the search
    @search = Search.find( params[:search][:id] )

    params[:tag].keys.each do |key| 
      if key =~ /tag_\d+$/ 
        @tag = Tag.find( params[:tag][key] )
      end
    end

    ## Make the SearchTag
    @search_tag  = SearchTag.find_or_initialize_by_search_id_and_tag_id( @search.id, @tag.id )

    if @search_tag.new_record?
      @search_tag_new = true
      @search_tag.save!
    end

    ## Add a Search Tag
    @search_tag    = SearchTag.find_or_create_by_search_id_and_tag_id( @search.id, @tag.id )

    ## Handle the response
    respond_to do |format|
      format.js { 
        render  :partial  => 'javascript/meta/create_clickable',
                :locals   => {  :meta_relation_new_flag => @search_tag_new,
                                :meta_obj               => @tag,
                                :relation_obj           => @search_tag, 
                                :main_obj_name          => 'search',
                                :meta_obj_name_singular => 'tag', :meta_obj_name_plural   => 'tags' }}

      format.html {
        redirect_to url_for(  :controller => :searches,
                              :action     => :show,
                              :id         => @search.id  )
      }

    end
  end

  def destroy
    @search_tag = SearchTag.find( params[:id] )
    @search     = @search_tag.search

    @search_tag.destroy

    respond_to do |format|
      format.js { 
        render  :partial  => 'javascript/meta/destroy_clickable',
                :locals   => {  :obj_meta_name => 'search_tag' }}

      format.html { redirect_to search_path( @search ), :success => 'Deleted!' }
    end
  end
end
