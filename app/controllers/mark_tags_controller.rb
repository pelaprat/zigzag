class MarkTagsController < ApplicationController

  def create

    @tag           = nil
    @mark_tag      = nil
    @mark_tag_new  = false

    # Get the item for this metting's mark
    @mark = Mark.find( params[:mark][:id] )
    @item = @mark.item

    ## Creating a relation to a Tag?
    if params[:tag][:name]
      @tag = Tag.find_or_create_by_name( params[:tag][:name].capitalize )

    else
      params[:tag].keys.each do |key| 
        if key =~ /tag_\d+$/ 
          @tag = Tag.find( params[:tag][key] )
         end
      end
    end

    ## Make the MarkTag
    @mark_tag  = MarkTag.find_or_initialize_by_mark_id_and_tag_id_and_user_id( @mark.id, @tag.id, @current_user.id )

    if @mark_tag.new_record?
      @mark_tag_new = true
      @mark_tag.save!
    end

    ## Add a User Tag and Author Tag
    @user_tag    = UserTag.find_or_create_by_user_id_and_tag_id( @current_user.id, @tag.id )

    ## Handle the response
    respond_to do |format|

      format.js { 
        render  :partial  => 'javascript/meta/create_clickable',
                :locals   => {  :meta_relation_new_flag => @mark_tag_new,
                                :meta_obj               => @tag,
                                :relation_obj           => @mark_tag, 
                                :main_obj_name          => 'mark',
                                :meta_obj_name_singular => 'tag', :meta_obj_name_plural   => 'tags' }}

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
    @mark_tag = MarkTag.find( params[:id] )
    @mark     = @mark_tag.mark
    @item     = @mark.item

    @mark_tag.destroy

    respond_to do |format|

      format.js { 
        render  :partial  => 'javascript/meta/destroy_clickable',
                :locals   => {  :obj_meta_name => 'mark_tag' }}

      format.html { redirect_to item_path( @item, :type => @item.type ), :success => 'Deleted!' }

    end
  end
end
