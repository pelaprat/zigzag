module ApplicationHelper

  ######################
  ## Highlight Tokens ##
  def highlight( keywords, string )
    if keywords.kind_of?(String)
      keywords = keywords.split(/\s+/)
    end

    keywords.each do |keyword|
      string.gsub!(/(#{keyword})/i, "<span class='highlight'>\\1</span>")
    end

    return string
  end

  ###########################################
  ## For sorting the columns of item lists ##
  def sortable_header( column, title = nil )

    title ||= column.titleize
    direction = column == params[:sort] && sort_direction == 'asc' ? 'desc' : 'asc'
    page = sort_page
    link_to title, params.merge(:sort => column, :direction => direction, :page => page )

  end

end
