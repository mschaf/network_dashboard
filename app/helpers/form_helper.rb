module FormHelper

  def cancel_submit_buttons(form)
    content_tag :div, class: 'mt-3' do
      html = ''.html_safe
      html << link_to('cancel', _back_url, class: 'btn btn-outline-secondary')
      html << form.button(:submit, class: 'btn btn-primary ms-2')
      html
    end
  end

end