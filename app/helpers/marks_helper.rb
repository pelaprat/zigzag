module MarksHelper

  ######################
  ## Highlight Tokens ##
  def tag_or_term_select_form_open( type, mark_id )
    return  "<form accept-charset='UTF-8' action='/mark_#{type}s' data-remote='true' id='mark-#{mark_id}-#{type}-form' method='post'><div style='margin:0;padding:0;display:inline'><input name='utf8' type='hidden' value='&#x2713;' /><input name='authenticity_token' type='hidden' value='noideawhatthiscouldbe' /></div>".html_safe
  end

  def tag_or_term_create_form_open( type )
    return "<form accept-charset='UTF-8' action='/mark_#{type}s' class='new-meta-form' data-remote='true' method='post'><div style='margin:0;padding:0;display:inline'><input name='utf8' type='hidden' value='&#x2713;' /><input name='authenticity_token' type='hidden' value='noideawhatthiscouldbe' /></div>".html_safe
  end

end
