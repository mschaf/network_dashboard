module EditDeleteHelper

  def edit_delete_icons(record)
    model_name = record.class.base_class.to_s.underscore
    html = ''.html_safe
    html << link_to(icon(:edit), public_send("edit_#{model_name}_path", record), 'up-modal': '.modal-content-wrapper')
    html << link_to(icon(:delete), public_send("#{model_name}_path", record), 'up-target': '.layout--content', 'up-method': :delete, 'up-confirm': "Do you really want to delete #{record}")
    html
  end

end