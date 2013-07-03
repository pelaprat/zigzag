class ReferenceController < ApplicationController
  skip_before_filter :require_login

  helper_method :sort_column, :sort_direction

  def index

    if @current_user && @current_user.id

      @search = UserItem.search do |query|
      	query.keywords  params[:search]
      	query.with      :user_id,   @current_user.id
      	query.with      :type,      ['Book', 'Article']

      	query.order_by  sort_column, sort_direction
      end
      @items    = @search.results.collect{ |ui| ui.item }

      f_filter = 1
      f_header = 1

      ## Handle the response
      respond_to do |format|
        format.js {
          render :layout => false 
        }
        format.html {
          render 'index', :layout => 'reference'
        }
      end
    else
      render 'login'
    end
  end

  private

  def sort_column
    %w[title author].include?(params[:sort]) ? sort_database_column : 'title'
  end

  def sort_database_column
    if params[:sort].eql? 'author'
      'authors.first.last'
    else
      params[:sort]
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
