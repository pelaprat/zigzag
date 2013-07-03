class ListsController < ApplicationController

  def index
    @lists = List.all
    @list  = List.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @lists }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @list }
    end
  end

  def new
    @list = List.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @list }
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def create
    @list = List.new(params[:list])

    if @list.save!
      redirect_to root_url, :notice => 'List was added!'
    else
      render 'new'
    end
  end

  def update
    @list = List.find(params[:id])

    if @list.save
      redirect_to root_url, :notice => 'List was updated!'
    else
      render 'new'
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_url }
      format.json { head :ok }
    end
  end
end
