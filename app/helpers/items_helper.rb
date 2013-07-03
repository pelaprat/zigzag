module ItemsHelper

  def item_search_form_open()
#    return "<form accept-charset='UTF-8' action='/searches' class='new_search' id='new_search' method='post'><div style='margin:0;padding:0;display:inline'><input name='utf8' type='hidden' value='&#x2713;' /><input name='authenticity_token' type='hidden' value='t05D3yjKIOUgWXeIs+qcyQ0bGDYmHxBmqIIF/1wfi7Y=' /></div>".html_safe
    return "<form accept-charset='UTF-8' action='/searches' class='new_search' id='new_search' method='post'><div style='margin:0;padding:0;display:inline'><input name='utf8' type='hidden' value='&#x2713;' /><input name='authenticity_token' type='hidden' value='' /></div>".html_safe
end


end
