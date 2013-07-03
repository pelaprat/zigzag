class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:create]

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  def show
    @user  = User.find(params[:id])

    @terms_with_frequency = MarkTerm.includes([:term]).select( ' *, count(term_id) as sum ').
                              where({ :user_id => 1}).group( :term_id ).order( 'sum desc' )

    @tags_with_frequency = MarkTag.includes([:tag]).select( ' *, count(tag_id) as sum ').
                              where({ :user_id => 1}).group( :tag_id ).order( 'sum desc' )

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    ## Only create a user if this is the
    ##  first user in the system... or if
    ##  the user is logged in as admin.
    if User.count.eql? 0
      @user = User.new(params[:user])
      @user.is_admin = true

      if @user.save
        redirect_to root_url, :notice => 'Adminstrator was added!'
      else
        render 'home/wall', :locals => { :wall_type => :initial_admin }
      end
    else
      redirect_to root_url, :alert => 'Cannot create user without permission!'
    end
  end

  def update

    @user = User.find(params[:id])

    if @user.save
      redirect_to root_url, :notice => 'User was updated!'
    else
      render 'new'
    end
  end

  def destroy

    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

  private

end
