class ItemsController < ApplicationController

  def show

    ## Get the right kind of item.
    if( params[:type].eql? 'Book' )
      @item  = Book.includes([:authors]).find( params[:id] )
    elsif( params[:type].eql? 'Chapter' )
      @item  = Chapter.includes([:authors, :book]).find( params[:id] )
    elsif( params[:type].eql? 'Article' )
      @item  = Article.includes([:authors, :journal]).find( params[:id] )
    end

    ##################################
    ## Get the marks for this item. ##
    @marks = Mark.
                includes([:user, :tags, :terms]).
                where({ :user_id => @current_user.id, :item_id => params[:id] }).
                order('page, id, updated_at asc')

    ##################################
    ## Make sure the last mark exists,
    ##  otherwise make a new one.
    @last_mark = @marks.last
    if ! @last_mark
      @last_mark = Mark.new()
    end

    ## Do some text formatting on the marks
    ##  and grab their ids.
    @marks.each do |m|
      m.quote   = m.quote.split(/\n/).join('<p>').html_safe
      m.comment = m.comment.split(/\n/).join('<p>').html_safe
    end

    ########################################
    ## Get the user terms for this author ##
    ##   and the and user's general tags. ##
    @user_terms = UserTerm.includes([:term]).
                    where({ :user_id => @current_user.id, :author_id => @item.authors_ids_as_array }).
                    collect{ |i| i.term }.
                    sort{ |x, y| x.name <=> y.name }

    @user_tags  = UserTag.includes([:tag]).where({ :user_id => @current_user.id }).
                    collect{ |i| i.tag }.
                    sort{ |x, y| x.name <=> y.name }

    respond_to do |format|
      format.html
      format.json { render :json => @item }
    end
  end

  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render :json => @items }
    end
  end

  def new
    @item      = Item.new
    @item.type = params[:type]

    @authors  = UserAuthor.includes([:author]).where({ :user_id => @current_user.id }).
                    collect{ |i| i.author }.
                    sort{ |x, y| x.last <=> y.last }

    @books    = @current_user.books.order( 'title asc')
    @journals = @current_user.journals.order( 'title asc')

    respond_to do |format|
      format.html
      format.json { render :json => @item }
    end
  end

  def edit

    @item       = Item.find(params[:id])
    @item_type  = @item.type

    @authors  = UserAuthor.includes([:author]).where({ :user_id => @current_user.id }).
                    collect{ |i| i.author }.
                    sort{ |x, y| x.last <=> y.last }


    @books    = @current_user.books.order( 'title asc')
    @journals = @current_user.journals.order( 'title asc' )

    respond_to do |format|
      format.html
      format.json { render :json => @item }
    end
  end

  def create

    ######################################
    ## Make the new item based on type. ##
    if( params[:item][:type].eql? 'Book' )
      @item = Book.find_or_initialize_by_title_and_isbn( params[:item] )
    elsif( params[:item][:type].eql? 'Chapter' )
      @item = Chapter.find_or_initialize_by_title_and_book_id( params[:item] )
    elsif( params[:item][:type].eql? 'Journal' )
      params[:item][:page_first] = params[:item][:page_last] = 0
      @item = Journal.find_or_initialize_by_title_and_isbn( params[:item] )
    elsif( params[:item][:type].eql? 'Article' )
      @item = Article.find_or_initialize_by_title_and_journal_id( params[:item] )
    end

    #####################################
    ## Build the authors for this item
    author_hash = params[:author_ids]
    author_hash.delete( "select-::FIELD1::" )
    author_hash.sort

    author_ids = []
    author_hash.values.each do |a|
      author_ids.push( :author_id => a )
    end

    @item.item_authors.build( author_ids )

    ####################
    ## Save the item. ##
    if @item.save
    
      ########################################
      ## If you add a book, you get all the ##
      ##  chapters for that book, too.      ##
      if @item.type.eql? 'Book'
        @item.chapters.each do |chapter|
          @user_item = UserItem.find_or_create_by_user_id_and_item_id( @current_user.id, chapter.id )
        end

      ###################################################
      ## Add a new book-chapter relation if necessary. ##
      elsif @item.type.eql? 'Chapter'
        @book_chapter = BookChapter.find_or_create_by_book_id_and_chapter_id( params[:item][:book_id], @item.id )
      end
    
      #################################
      ## Add item to the user's list ##
      @user_item = UserItem.find_or_create_by_user_id_and_item_id( @current_user.id, @item.id )
    
      redirect_to url_for( :controller => :home, :action => :index ),
        :notice => 'Item was successfully inserted into the database!'
    
    else
      respond_to do |format|
    
        ## Reload these items for the add-item form
        @authors  = Author.find( :all, :order => :last )
        @books    = Book.find( :all, :order => :title )
        @journals = Journal.find( :all, :order => :title )

        format.html { render :controller => :item, :action => :new }
        format.json { render :json => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    ################################
    ## Load the object from params
    @item = Item.find(params[:id])

    ######################################
    ## Update basic properties of the item
    if params.key?(:item)
      @item_param_data = params[:item]

      # flag_chapters
      if @item_param_data.key?(:flag_chapters) and @item_param_data[:flag_chapters].to_i >= 0
        @item.flag_chapters = @item_param_data[:flag_chapters] 
      end

      # flag_sections
      if @item_param_data.key?(:flag_sections) and @item_param_data[:flag_sections].to_i >= 0
        @item.flag_sections = @item_param_data[:flag_sections] 
      end

      # page_first
      if @item_param_data.key?(:page_first) and @item_param_data[:page_first].to_i > 0
        @item.page_first = @item_param_data[:page_first] 
      end

      # page_last
      if @item_param_data.key?(:page_last) and @item_param_data[:page_last].to_i > 0
        @item.page_last = @item_param_data[:page_last] 
      end

      # year
      if @item_param_data.key?(:year) and @item_param_data[:year].to_i > 0
        @item.year = @item_param_data[:year] 
      end

      # title
      if @item_param_data.key?(:title) and not @item_param_data[:title].empty?
        @item.title = @item_param_data[:title] 
      end

      # isbn
      if @item_param_data.key?(:isbn) and not @item_param_data[:isbn].empty?
        @item.isbn = @item_param_data[:isbn] 
      end

      # update the book this chapter belongs to?
      if @item.type.eql? 'Chapter' and @item_param_data.key?(:book_id) and @item_param_data[:book_id].to_i > 0

        @current_book_chapter = BookChapter.find_by_book_id_and_chapter_id( @item.book.id, @item.id )

        if @current_book_chapter

          ## Delete the current association
          @current_book_chapter.delete

          ## Create a new association
          @new_book_chapter = BookChapter.find_or_create_by_book_id_and_chapter_id( @item_param_data[:book_id], @item.id )
          @new_book_chapter.save

          ## Update the book_id in the item table
          @item.book_id = @item_param_data[:book_id].to_i
        end
      end
    end

    ############################
    ## Delete existing authors
    existing_authors = ItemAuthor.where({ :item_id => @item.id })
    existing_authors.each do |ea|
      ea.delete
    end

    #####################################
    ## Build the authors for this item
    author_hash = params[:author_ids]
    author_hash.delete( "select-::FIELD1::" )
    author_hash.sort

    author_ids = []
    author_hash.values.each do |a|
      author_ids.push( :author_id => a )
    end

    @item.item_authors.build( author_ids )

    #############################
    ## Respond based on success
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, :notice => 'Item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :ok }
    end
  end


  private

  def etienne
    x = 1
  end

end
