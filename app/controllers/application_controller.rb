class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :load_constants
  before_filter :current_user
  before_filter :require_login, :except => 'login'

  before_filter :set_debug_clock

  def set_debug_clock
    @debug_clock = Time.now()
  end

  private

  ####################################
  ## Constants and Login Related Functions
  def load_constants
    @g_mark_types = [ :Quote,   :Comment, :Divider            ]
    @g_mark_areas = [ :Top,     :Middle,  :Bottom             ]
    @g_item_types = [ :Chapter, :Book,    :Journal, :Article  ]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless @current_user
      redirect_to root_url
    end
  end

  ###########################################
  ## For sorting the columns of item lists ##
  def sort_page
    ( params.key?(:page) and params[:page].to_i > 0 ) ? params[:page].to_i : 1
  end

  def sort_column
    %w[title author].include?( params[:sort] ) ? params[:sort] : 'title'
  end

  def sort_column_for_solr
    if sort_column.eql? 'author'
      'author_name'
    else
      sort_column
    end
  end

  def sort_direction
    %w[asc desc].include?( params[:direction] ) ? params[:direction] : 'asc'
  end
  
  helper_method :current_user
  helper_method :sort_page, :sort_column, :sort_column_for_solr, :sort_direction
end
