class MarksController < ApplicationController

  def create

    if( params[:mark][:type].eql? 'Quote' )
      @mark = Quote.new( params[:mark] )
    elsif( params[:mark][:type].eql? 'Comment' )
      @mark = Comment.new( params[:mark] )
    elsif( params[:mark][:type].eql? 'Divider' )
      @mark = Divider.new( params[:mark] )
    else
      redirect_to url_for( :controller => :home, :action => :index ),
                  :error => 'Error on mark type in marks_controller/create.'
    end

    if( params[:item][:type] )
    else
      redirect_to url_for( :controller => :home, :action => :index ),
                  :error => 'Error on item type in marks_controller/create.'
    end

    if @mark.save!
      redirect_to url_for(  :controller => :items, :action => :show,
                            :type => params[:item][:type], :id => params[:item][:id] ),
                  :success => 'Mark was successfully inserted into the database!'
    else
      redirect_to root_url, :error => 'Error submitting the mark'
    end
  end

  def update
    @mark = Mark.find(params[:id])
    @item = Item.find( @mark.item_id );

    if @mark.update_attributes(params[:mark]) && @item
      redirect_to url_for( @item ),
                  :success => 'Mark was successfully updated!'

    else
      format.html { render :action => "edit" }
      format.json { render :json => @mark.errors, :status => :unprocessable_entity }
    end
  end

  def destroy
    @mark = Mark.find(params[:id])
    @mark.destroy

    respond_to do |format|
      format.html { redirect_to marks_url }
      format.json { head :ok }
    end
  end

  def edit
    @mark = Mark.find(params[:id])
  end
end
