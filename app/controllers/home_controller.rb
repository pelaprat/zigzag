class HomeController < ApplicationController
  skip_before_filter :require_login

  helper_method :sort_column, :sort_direction
  helper_method :sort_page

  def index
    @items   = []
    @f_books = @f_articles = @f_filter = @f_header = 1

    # This recognizes a JS/Ajax subquery
    if params.key?(:sort) && params.key?(:search)
      @f_books     = params[:f_books].to_i 
      @f_articles  = params[:f_articles].to_i
    end

    @keywords = params.key?(:search) ? params[:search].to_s : ''

    if @current_user and @current_user.id > 0
      render_for_authenticated_user

    elsif User.count.eql? 0
      render_for_new_install

    else
      render_for_visitor
    end
  end


  private

  def render_for_visitor
    render 'wall', :locals => { :wall_type => :login }
  end

  def render_for_new_install
    @user = User.new
    render 'wall', :locals => { :wall_type => :initial_admin }
  end

  def render_for_authenticated_user
    run_item_query_through_sunspot

    ## Handle the response
    respond_to do |format|
      format.js { 
        render :layout => false 
      }
      format.html {
        render 'index'
      }
    end
  end

  def run_item_query_through_sunspot

    @query = UserItem.search(:include => [:item]) do |query|

      query.fulltext @keywords

      query.with    :user_id, @current_user.id

      query.without :type, 'Book'     if @f_books == 0
      query.without :type, 'Article'  if @f_articles == 0

      if @keywords.empty?
        query.without :type, 'Chapter'
        query.without :type, 'Journal'
      end

      query.order_by  sort_column_for_solr, sort_direction
      query.paginate :page => sort_page, :per_page => 10
    end

    @items = @query ? @query.results.map{ |result| result.item } : []

  end

  def run_item_query_through_rails

    ## If we have search criteria....
    unless @keywords.empty?
      mysql  = "user_items.user_id = ? and (authors.last like ? or authors.first like ? or items.title like ? or chapters_items.title like ?)"
      @items += Book.includes(:user_items, :authors, :chapters).where(mysql, @current_user.id, "%#{@keywords}%", "%#{@keywords}%", "%#{@keywords}%", "%#{@keywords}%").all

      mysql  = "user_items.user_id = ? and (authors.last like ? or authors.first like ? or items.title like ? or journals_items.title like ?)"
      @items += Article.includes(:user_items, :authors, :journal).where(mysql, @current_user.id, "%#{@keywords}%", "%#{@keywords}%", "%#{@keywords}%", "%#{@keywords}%").all

    else 
      @items += Book.includes(:user_items, :authors, :chapters).where("user_items.user_id = #{@current_user.id}").all   if @f_books == 1
      @items += Article.includes(:user_items, :authors).where("user_items.user_id = #{@current_user.id}").all if @f_articles == 1
    end

    if sort_column.eql? :author
      @items = @items.sort_by( &:author_name )
    else
      @items = @items.sort_by( &:title )
    end

    @items = @items.reverse if sort_direction.eql? 'desc'
  end
  
  private



  


end
