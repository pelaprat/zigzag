# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Zigzag::Application.initialize!

ActionView::Base.field_error_proc = Proc.new { |html_tag, instance| %Q(<span class="field_with_errors">#{html_tag}</span>).html_safe }