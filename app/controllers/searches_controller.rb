class SearchesController < ApplicationController

  def show

    @search = Search.find( params[:id] )

    @query = Mark.search do |query|

      unless @search.keywords.nil? or @search.keywords.empty?
        query.fulltext @search.keywords
      end

      if @search.tags.map(&:id).empty? == false
        query.with    :tag_ids, @search.tags.map(&:id)
      end

      if @search.terms.map(&:id).empty? == false
        query.with    :term_ids, @search.terms.map(&:id)
      end

      query.with    :user_id, @search.user_id
      query.with    :item_id, @search.item_id if @search.f_single_item_search
      query.with    :type,    'Quote'      if @search.f_quoted_text_only

      query.paginate :page => sort_page, :per_page => 10

      query.order_by  :created_at, :desc
    end

    @marks = @query ? @query.results : []

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @search }
    end
  end

  def new
    @search = Search.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @search }
    end
  end

  def create
    item_id               = 0
    f_quoted_text_only    = false
    f_single_item_search  = false
    keywords              = ''

    ## Did we get search criteria to fill out this search object?
    if( params.key?( :search ) )
      search_params = params[:search]
      keywords      = search_params.key?(:keywords) ? search_params[:keywords] : ''
      item_id       = ( search_params.key?(:item_id) && search_params[:item_id].to_i > 0 ) ? 
        search_params[:item_id].to_i  : -1

      f_single_item_search = ( item_id > 0 ) ? true : false
    end
  
    @search = Search.new({  :name                 => @current_user.id.to_s + ':search:' + Time.now().strftime("%s"),
                            :user_id              => @current_user.id,
                            :f_quoted_text_only   => f_quoted_text_only,
                            :f_single_item_search => f_single_item_search,
                            :keywords             => keywords,
                            :item_id              => item_id })

    respond_to do |format|
      if @search.save!
        format.html { redirect_to @search }
        format.json { render :json => @search, :status => :created, :location => @search }
      else
        format.html { render :action => "new" }
        format.json { render :json => @search.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    @search = Search.find( params[:id] )

    ## Keywords
    @search.keywords =
      params[:search][:keywords].nil? ? '' : params[:search][:keywords]

    ## Flags
    @search.f_quoted_text_only =
      ( params[:search][:f_quoted_text_only].nil? or 
        params[:search][:f_quoted_text_only].eql? '0' ) ? false : true

    @search.f_single_item_search =
      ( params[:search][:f_single_item_search].nil? or 
        params[:search][:f_single_item_search].eql? '0' ) ? false : true

    ## Tags
    unless params[:tags].nil?
      @search.set_meta_from_params_hash( 'tag', params[:tags] )
    end

    ## Terms
    unless params[:terms].nil?
      @search.set_meta_from_params_hash( 'term', params[:terms] )
    end

    respond_to do |format|
      if  @search.save!
        format.html { redirect_to @search, :notice => 'Search was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @search.errors, :status => :unprocessable_entity }
      end
    end
  end

end

