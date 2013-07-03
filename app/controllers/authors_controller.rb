class AuthorsController < ApplicationController

  def new
    @author = Author.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @author }
    end
  end

  def create

    if valid_param_data?
      clean_param_data

      unless @first.empty? or @last.empty?
        @author       = Author.find_or_create_by_first_and_last( @first, @last );
        @user_author  = UserAuthor.find_or_create_by_user_id_and_author_id({ :user_id => @current_user.id, :author_id => @author.id })

        if @author.save! && @user_author.save!
          redirect_to root_url, :notice => 'Author was added!'
        else
          render 'new'
        end
      end

    else
      render 'new'
    end
  end

  def show

    @f_filter = @f_header = 1
    @author   = Author.find( params[:id] )

    @query    = UserItem.search(:include => [:item]) do |query|

      query.with    :user_id, @current_user.id
      query.with    :author_id, params[:id]

      query.without :type, 'Chapter'
      query.without :type, 'Journal'

      query.order_by sort_column_for_solr, sort_direction
      query.paginate :page => sort_page, :per_page => 10
    end

    @items = @query ? @query.results.map{ |result| result.item } : []

    ## Handle the response
    respond_to do |format|
      format.js { 
        render :layout => false 
      }
      format.html {
        render 'show'
      }
    end

  end


  private

  def valid_param_data?
    params.key?(:author)
  end

  def clean_param_data
    author = params[:author]

    @first = author.key?(:first) ? author[:first] : ''
    @first.strip!

    @last = author.key?(:last)  ? author[:last]  : ''
    @last.strip!
  end


end
